/*SOURCES*/drop table if exists enriched_customer;
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
FROM   samples.tpch.customer t; drop table if exists enriched_nation;
CREATE TABLE enriched_nation AS
/*Compiled on 2024-08-22 18:59:54.525598+00 mode=input*/
SELECT t.n_comment,
       t.n_name,
       t.n_nationkey,
       t.n_regionkey
FROM   samples.tpch.nation t; drop table if exists enriched_orders;
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
FROM   samples.tpch.orders t; drop table if exists enriched_lineitem;
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
        ON j_3_1.c_nationkey = j_3_1_2.n_nationkey;drop table if exists lineitem_by_nation_date;
        /*OUTPUTs*/
CREATE TABLE lineitem_by_nation_date as with agg_cte AS(SELECT t.nation_key as nation_key,
                                                               t.l_receiptdate as line_item_receipt_date,
                                                               sum(t.net_price_int) as line_item_net_price_100
                                                        FROM   enriched_lineitem t
                                                        WHERE  true
                                                        GROUP BY t.nation_key, t.l_receiptdate)
SELECT *
FROM   agg_cte