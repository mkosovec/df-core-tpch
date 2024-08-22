drop table if exists enriched_customer;
CREATE TABLE enriched_customer AS
/*Compiled on 2024-08-22 18:59:54.525598+00 mode=input*/
SELECT t.c_acctbal,
       t.c_comment,
       t.c_custkey,
       t.c_name,
       t.c_phone,
       t.c_address,
       t.c_mktsegment,
       t.c_nationkey
FROM   samples.tpch.customer t;