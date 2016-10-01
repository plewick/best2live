from glob import glob
import json

net_speeds = []

LOCAL_TECH = {"LAN", "WLAN"}
PROPERTIES = {"lat", "long", "download_kbit", "upload_kbit", "ping_ms"}

for f in glob("../datasets/netmetr/*.csv"):
    with open(f) as d:
        first = True
        header = None
        for i in d:
            data = i.split(',')
            if first:
                header = data
                first = False
                continue

            net_speeds.append(dict(zip(header, data)))

print("STATS")
print("types {}".format(set([i["cat_technology"] for i in net_speeds])))
print("types {}".format(set([i["network_type"] for i in net_speeds])))
print("LAN {}".format(
    len([i for i in net_speeds if i["cat_technology"] == "LAN"])))
print("WLAN {}".format(
    len([i for i in net_speeds if i["cat_technology"] == "WLAN"])))

# split data to local and cellular
local = [i for i in net_speeds if i["cat_technology"] in LOCAL_TECH]
cell = [i for i in net_speeds if i["cat_technology"] not in LOCAL_TECH]

local = filter(lambda x: x["lat"] and x["long"], local)
cell = filter(lambda x: x["lat"] and x["long"], cell)

print("SIZES")
print("loc {}, cell {}".format(len(local), len(cell)))

json.dump([{k: float(i[k]) if i[k] else None for k in PROPERTIES} for i in local],
          open("../data/netmetr_local.json", "w"))
json.dump([{k: float(i[k]) if i[k] else None for k in PROPERTIES} for i in cell],
          open("../data/netmetr_cell.json", "w"))



