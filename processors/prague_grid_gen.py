import math

MIN_LON = 14.236084102549702
MIN_LAT = 49.921228499886737
MAX_LON = 14.698778906022072
MAX_LAT = 50.197986451948502

DESIRED_POINT_CNT = 5 * 10 ** 5
lat_len_prague = MAX_LAT - MIN_LAT
lon_len_prague = MAX_LON - MIN_LON

sq_area = (lat_len_prague * lon_len_prague) / DESIRED_POINT_CNT
print(sq_area)
sq_ratio = lat_len_prague / lon_len_prague
print(sq_ratio)
lat_len = math.sqrt(sq_area) * sq_ratio
lon_len = math.sqrt(sq_area) * (1 / sq_ratio)

avg_step = (lat_len + lon_len) / 2

with open("../data/prague_grid.sql", 'wa') as f:
    lat_pos = MIN_LAT
    while lat_pos < MAX_LAT:
        f.write("INSERT INTO prague_grid(pos) VALUES ")
        lon_pos = MIN_LON
        while lon_pos < MAX_LON:
            #  print(lat_pos, lon_pos)
            f.write("(ST_Point({}, {}))".format(lon_pos, lat_pos))
            lon_pos += avg_step  # lon_len
            if lon_pos < MAX_LON:
                f.write(',')
        lat_pos += avg_step  # lat_len
        f.write(";\n")
