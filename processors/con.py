def con():
    import psycopg2

    try:
        return psycopg2.connect(
            "dbname='hacks' user='postgres' host='13.93.50.100' password='Best2livemaps'")
    except:
        print "I am unable to connect to the database"
