/*
  the order & fare pct_growth for the first year of booking data will be {NULL}
*/
SELECT
  YEAR(order_date) as order_year
  ,line_of_business
  ,count(*) as orders
  ,100*(count(*) / NULLIF(LAG(count(*), 1) OVER (PARTITION BY line_of_business ORDER BY YEAR(order_date) asc),0) - 1) as order_pct_growth
  ,sum(fare) as total_fares
  ,100*(sum(fare) / NULLIF(LAG(sum(fare), 1) OVER (PARTITION BY line_of_business ORDER BY YEAR(order_date) asc),0) - 1) as fare_pct_growth
FROM
  booking
GROUP BY
  YEAR(order_date)
  ,line_of_business
