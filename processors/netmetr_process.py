import json
from glob import glob
import scipy

PROPS = {"download_kbit", "upload_kbit", "ping_ms"}

open("../data/netmetr.sql", 'wa')

for f in glob("../data/netmetr_*.json"):
    print(f)
    stats = {}
    j = json.load(open(f))

    for p in PROPS:
        d = [i[p] for i in j if i[p]]
        stats[p] = {
            "min": min(d),
            "max": max(d),
            "avg": scipy.mean(d),
            "median": scipy.median(d),
            "cnt": len(d),
        }

        stats[p]["len"] = stats[p]["max"] - stats[p]["min"]

    for i in j:
        for p in PROPS:
            v = i[p]
            if v:
                v = v - stats[p]["min"]
                v /= stats[p]["len"]
                if "ping" in p:
                    v *= -1
                i["{}-{}".format(p, "index")] = v
            else:
                i["{}-{}".format(p, "index")] = 0.

    with open("../data/netmetr.sql", 'a') as w:
        tech = f.split("_")[1].replace(".json", "")
        w.write("INSERT INTO netmetr(pos, up, down, ping, tech) VALUES ")
        p = 0
        for i in j:
            w.write("(ST_Point({}, {}), {}, {}, {}, '{}')".format(
                i["long"], i["lat"], i["upload_kbit-index"],
                i["download_kbit-index"], i["ping_ms-index"], tech))
            p += 1
            if p < len(j):
                w.write(',')
        w.write(';\n')

    # print(j)
