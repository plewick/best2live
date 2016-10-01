#!/usr/bin/env bash

psql -d "postgresql://postgres:Best2livemaps@13.93.50.100/hacks" -W -f "${1}"
