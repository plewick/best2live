FROM python:alpine

RUN apk update && apk add postgresql-dev python-dev gcc musl-dev

RUN pip install psycopg2 flask

RUN mkdir /app

ADD *.py /app

CMD export FLASK_APP=/app/main.py; python -m flask run --host=0.0.0.0

EXPOSE 5000