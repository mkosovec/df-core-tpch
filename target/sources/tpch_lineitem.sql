drop table if exists enriched_lineitem;
CREATE TABLE enriched_lineitem AS
/*Compiled on 2024-08-22 18:59:54.525598+00 mode=input*/
SELECT t.l_returnflag,
       t.l_shipinstruct,
       t.l_suppkey,
       t.l_comment,
       t.l_discount,
       t.l_linenumber,
       t.l_linestatus,
       t.l_orderkey,
       t.l_partkey,
       t.l_commitdate,
       t.l_extendedprice,
       t.l_quantity,
       t.l_receiptdate,
       t.l_shipdate,
       t.l_shipmode,
       t.l_tax,
       cast((t.l_extendedprice - t.l_tax - t.l_discount)*100 as decimal(38, 12)) net_price_int,
       j_3_1_2.n_nationkey nation_key
FROM   samples.tpch.lineitem t
    LEFT JOIN enriched_orders j_3
        ON t.l_orderkey = j_3.o_orderkey
    LEFT JOIN enriched_customer j_3_1
        ON j_3.o_custkey = j_3_1.c_custkey
    LEFT JOIN enriched_nation j_3_1_2
        ON j_3_1.c_nationkey = j_3_1_2.n_nationkey;