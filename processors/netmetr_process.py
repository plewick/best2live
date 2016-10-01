import json
from glob import glob
import scipy


PROPS = {"download_kbit", "upload_kbit", "ping_ms"}

for f in glob("../data/netmetr_*"):
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
        }
    print stats
