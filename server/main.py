# import tornado.ioloop
# import tornado.web
# import aiopg
# import asyncio
# from aiopg.sa import create_engine as aiopg_create_engine
import psycopg2
import json
# dsn = 'dbname=hacks user=postgres password=Best2livemaps host=13.93.50.100'

from flask import Flask
import psycopg2.extras
import json
import flask

app = Flask(__name__)


def _get_engine():
    return psycopg2.connect(
        "dbname='hacks' user='postgres' host='13.93.50.100' password='Best2livemaps'")


@app.route("/")
def hello():
    conn = _get_engine()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(
        """SELECT ST_X(pos::geometry) as lng, ST_Y(pos::geometry) as lat, down, up, ping, tech from a_netmetr WHERE down IS NOT NULL LIMIT 1000""")
    rows = cur.fetchall()
    data = [dict(i) for i in rows]
    coef = {
        "down": 1,
        "up": 1,
        "ping": 1,
    }
    data = [{
                "lat": i["lat"],
                "lng": i["lng"],
                "val": sum([v * coef[k] for k, v in i.items() if k in coef])
            } for i in data]
    resp = flask.Response(json.dumps(str(data)))
    resp.headers['Content-type'] = 'text/json'
    return resp


if __name__ == "__main__":
    app.run()

# class MainHandler(tornado.web.RequestHandler):
#     def _get_engine(self):
#         psycopg2.connect(
#             "dbname='hacks' user='postgres' host='13.93.50.100' password='Best2livemaps'")
#         # engine = yield from aiopg_create_engine(user='postgres',
#         #                                         database='hacks',
#         #                                         host='13.93.50.100',
#         #                                         password='Best2livemaps')
#         # return engine
#
#     # @asyncio.coroutine
#
#
#     def select(self, table_object):
#         engine = yield from self._get_engine()
#         with (yield from engine) as conn:
#             with conn.cursor() as cur:
#                 data = cur.execute("SELECT 1")
#                 # data = yield from conn.execute(table_object)
#         return data
#
#
#     def get(self):
#         conn = self._get_engine()
#         cur = conn.cursor()
#         cur.execute("""SELECT 1""")
#         rows = cur.fetchall()
#         for row in rows:
#             self.write(str(type(row)))
#         self.write("DONE")
#
#         # with aiopg.create_pool(dsn) as pool:
#         #     with pool.acquire() as conn:
#         #         with conn.cursor() as cur:
#         #             cur.execute("SELECT 1")
#         #             for row in cur:
#         #                 ret.append(row)
#         #                 self.write(row)
#
#
# def make_app():
#     return tornado.web.Application([
#         (r"/", MainHandler),
#     ], debug=True)
#
#
# if __name__ == "__main__":
#     app = make_app()
#     app.listen(8888)
#     tornado.ioloop.IOLoop.current().start()
