drop table if exists enriched_orders;
CREATE TABLE enriched_orders AS
/*Compiled on 2024-08-22 18:59:54.525598+00 mode=input*/
SELECT t.o_custkey,
       t.o_orderkey,
       t.o_orderpriority,
       t.o_orderstatus,
       t.o_shippriority,
       t.o_totalprice,
       t.o_clerk,
       t.o_comment,
       t.o_orderdate
FROM   samples.tpch.orders t;