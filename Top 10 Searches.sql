/*
  The prompted "Top Searches by Year" was a bit vague given the number of
  attributes users can search by. I am making two inferences from the prompt:

  1)  I am assuming all search attributes for a given flight, hotel, car can be
      populated at the same time.

  2)  A search for a flight from JFK to LAX at 1200 is distinct from
      a similar search from JFK to LAX at 1600.

  e.g. Given 2019 was the first year data was collected and the and most
  common search was flights from JKF to LAX from 6am to 9am for 1 ticket, then
  the first output row would be..
  YEAR  |RANK| line_of_business | flight_from | flight_to | depart_time | arrival_time  | ticket_count  | hotel_city  | hotel_state | hotel_rooms | car_model | car_passengers
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  2019  | 1 | flights           | JFK         | LAX       | 600         | 900           | 1             | NULL        | NULL        | NULL        | NULL      | NULL

*/
SELECT
  *
FROM
  (
  SELECT
    YEAR(search_date) as search_year
    ,ROW_NUMBER() OVER (PARTITION BY YEAR(search_date) ORDER BY count(*) desc) as year_rank
    ,line_of_business
    ,search_type_cd
    ,flight_from
    ,flight_to
    ,depart_time
    ,arrival_time
    ,ticket_count
    ,hotel_city
    ,hotel_state
    ,hotel_rooms
    ,car_model
    ,car_passengers

  FROM
    searches
  GROUP BY
    YEAR(search_date)
    ,line_of_business
    ,search_type_cd
    ,flight_from
    ,flight_to
    ,depart_time
    ,arrival_time
    ,ticket_count
    ,hotel_city
    ,hotel_state
    ,hotel_rooms
    ,car_model
    ,car_passengers
  )
WHERE
  year_rank <= 10
ORDER BY
  search_year asc
  ,year_rank asc
;
