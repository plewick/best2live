#!/usr/bin/env python3

import con
import sys

cc = con.con()
c = cc.cursor()

table  = sys.argv[1]
column = sys.argv[2]

c.execute("SELECT MIN({}) as min, MAX({}) as max FROM {};".format(column, column, table));

mi, mx = c.fetchone()

if (mx == 0):
    mx = 1;

c.execute("UPDATE {} SET {} = ({}-{})/{};".format(table, column, column, mi, mx))

cc.commit()

