DROP TABLE IF EXISTS air_polution_data;
CREATE TABLE public.air_polution_data
(
  grid_id integer PRIMARY KEY,
  value double precision
)
WITH (
  OIDS=FALSE
);

DROP INDEX IF EXISTS public.air_polution_data_grid_id_idx;
CREATE INDEX air_polution_data_grid_id_idx
  ON public.air_polution_data
  USING btree
  (grid_id NULLS FIRST);

INSERT INTO air_polution_data (grid_id, value) (SELECT g.id, pm10_rp FROM prague_grid AS g LEFT JOIN sit1000_5lprum_10_14_wgs84 AS d ON ST_Within(CAST(g.pos AS geometry), CAST(d.wkb_geometry AS geometry)));
