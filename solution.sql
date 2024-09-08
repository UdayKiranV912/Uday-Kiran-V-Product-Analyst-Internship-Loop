WITH UberEats AS (
 SELECT
   JSON_VALUE(response, '$.data.menus."26bd579e-5664-4f0a-8465-2f5eb5fbe705".sections[0].regularHours[0].startTime') AS UberEats_startTime,
   JSON_VALUE(response, '$.data.menus."26bd579e-5664-4f0a-8465-2f5eb5fbe705".sections[0].regularHours[0].endTime') AS UberEats_endTime,
   STRUCT(
     b_name AS b_name,
     vb_name AS vb_name
   ) AS restaurant_info
 FROM
   `arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours`
),


GrubHub AS (
 SELECT
   JSON_VALUE(response, '$.today_availability_by_catalog.STANDARD_DELIVERY[0].from') AS GrubHub_startTime,
   JSON_VALUE(response, '$.today_availability_by_catalog.STANDARD_DELIVERY[0].to') AS GrubHub_endTime,
   STRUCT(
     b_name AS b_name,
     vb_name AS vb_name
   ) AS restaurant_info
 FROM
   `arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours`
)
SELECT
 UberEats.UberEats_startTime,
 UberEats.UberEats_endTime,
 UberEats.restaurant_info AS UberEats_restaurant_info,
 GrubHub.GrubHub_startTime,
 GrubHub.GrubHub_endTime,
 GrubHub.restaurant_info AS GrubHub_restaurant_info,
 CASE
   WHEN GrubHub.GrubHub_startTime >= UberEats.UberEats_startTime
     AND GrubHub.GrubHub_endTime <= UberEats.UberEats_endTime THEN 'In Range'
   WHEN GrubHub.GrubHub_startTime < UberEats.UberEats_startTime
     OR GrubHub.GrubHub_endTime > UberEats.UberEats_endTime THEN 'Out of Range'
   ELSE 'Out of Range with 5 mins difference'
 END AS is_out_of_range
FROM UberEats
INNER JOIN GrubHub
ON UberEats.restaurant_info = GrubHub.restaurant_info;
