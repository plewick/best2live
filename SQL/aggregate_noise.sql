DROP TABLE IF EXISTS noise_data;
CREATE TABLE public.noise_data
(
  grid_id integer PRIMARY KEY,
  value double precision
)
WITH (
  OIDS=FALSE
);

DROP INDEX IF EXISTS public.noise_data_grid_id_idx;
CREATE INDEX noise_data_grid_id_idx
  ON public.noise_data
  USING btree
  (grid_id NULLS FIRST);

INSERT INTO noise_data (grid_id, value) (SELECT g.id, db_hi FROM prague_grid AS g LEFT JOIN hm_ekola_adp_pasma_den_p AS d ON ST_Within(CAST(g.pos AS geometry), CAST(d.wkb_geometry AS geometry)));
