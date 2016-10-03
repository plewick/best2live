import psycopg2

from flask import Flask
import psycopg2.extras
import json
import flask
from flask import request

app = Flask(__name__)


def _get_engine():
    return psycopg2.connect(
        "dbname='hacks' user='postgres' host='13.93.50.100' password='Best2livemaps'")


def net_data(data, res, global_coef):
    coef = {
        "down": 1 * global_coef,
        "up": 1 * global_coef,
        "ping": 1 * global_coef,
    }
    for i in data:
        res[i["pos_id"]]["values"].append(
            sum([v * coef[k] for k, v in i.items() if k in coef]) / 3)


@app.route("/")
def hello():
    try:
        nelat = float(request.args.get('nelat'))
        nelng = float(request.args.get('nelng'))
        swlng = float(request.args.get('swlng'))
        swlat = float(request.args.get('swlat'))
        zoom = request.args.get('zoom')
        cell_coef = float(request.args.get('cell'))
        local_coef = float(request.args.get('local'))
        pollution_coef = float(request.args.get('pollution'))

        conn = _get_engine()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute(
            """SELECT ST_X(n.pos::geometry) as lng, ST_Y(n.pos::geometry) as lat,
              n.down, n.up, n.ping, n.tech, n.pos_id, p.value as pollution from a_netmetr as n
              JOIN air_polution_data as p ON p.grid_id = n.pos_id
              WHERE ST_Contains(ST_MakeEnvelope(%s, %s, %s, %s, 4326),
              CAST(n.pos as geometry))
              """, (swlng, swlat, nelng, nelat))
        rows = cur.fetchall()
        data = [dict(i) for i in rows]
        # None to 0.5
        data = [{k: v if v else (0.5 if k in {"down", "up", "ping"} else None)
                 for k, v in i.items()} for i in data]

        local = [i for i in data if not i["tech"] or i["tech"] == "local"]
        cell = [i for i in data if not i["tech"] or i["tech"] == "cell"]

        results = {
            i["pos_id"]: {
                "lat": i["lat"],
                "lng": i["lng"],
                "values": [],
            } for i in local
            }

        for i in cell:
            if i["pos_id"] not in results:
                results[i["pos_id"]] = {
                    "lat": i["lat"],
                    "lng": i["lng"],
                    "values": [],
                }

        for i in data:
            if i["pollution"]:
                results[i["pos_id"]]["values"].append(i["pollution"] * -pollution_coef)

        net_data(local, results, local_coef)
        net_data(cell, results, cell_coef)

        ret = [{
                   "lat": i["lat"],
                   "lng": i["lng"],
                   "val": sum(i["values"]) / len(i["values"])
               } for i in results.values()]

        resp = flask.Response(json.dumps(ret))
        resp.headers['Content-type'] = 'text/json'
        resp.headers['Access-Control-Allow-Origin'] = '*'
        return resp
    except Exception as e:
        print(e)
        return json.dumps([])


if __name__ == "__main__":
    app.run()
