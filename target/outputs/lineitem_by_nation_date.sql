drop table if exists lineitem_by_nation_date;
CREATE TABLE lineitem_by_nation_date as with agg_cte AS(SELECT t.nation_key as nation_key,
                                                               t.l_receiptdate as line_item_receipt_date,
                                                               sum(t.net_price_int) as line_item_net_price_100
                                                        FROM   enriched_lineitem t
                                                        WHERE  true
                                                        GROUP BY t.nation_key, t.l_receiptdate)
SELECT *
FROM   agg_cte