drop table if exists enriched_nation;
CREATE TABLE enriched_nation AS
/*Compiled on 2024-08-22 18:59:54.525598+00 mode=input*/
SELECT t.n_comment,
       t.n_name,
       t.n_nationkey,
       t.n_regionkey
FROM   samples.tpch.nation t;