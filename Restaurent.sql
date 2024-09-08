-- View the menu_items table
SELECT * FROM restaurant_db.menu_items;

-- Find the number of items on the menu
SELECT COUNT(*) AS number_of_items FROM menu_items;

-- find the least and the most expensive items on the menu
select item_name,price from restaurant_db.menu_items
where price = (select min(price) from restaurant_db.menu_items);

select item_name,price from restaurant_db.menu_items
where price = (select max(price) from restaurant_db.menu_items);

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
select item_name,price from restaurant_db.menu_items
where price = (select max(price) from restaurant_db.menu_items where category = 'Italian');

select item_name,price from restaurant_db.menu_items
where price = (select min(price) from restaurant_db.menu_items where category = 'Italian');

-- How many dishes are in each category? What is the average dish price within each category?
SELECT
  category,
  COUNT(item_name) AS number_of_dishes,
  AVG(price) AS average_price
FROM restaurant_db.menu_items
GROUP BY category;


-- ------------------------------xx----------------------------- --

-- View the order_details table. What is the date range of the table?

SELECT
  MIN(order_date) AS start_date,
  MAX(order_date) AS end_date
FROM restaurant_db.order_details;

-- How many orders were made within this date range? How many items were ordered within this date range?
select * from restaurant_db.order_details;

SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    count( order_details_id) AS total_items_ordered
FROM 
	restaurant_db.order_details;
    
-- Which orders had the most number of items?

select order_id,count(item_id) as Num_items from restaurant_db.order_details
group by order_id
order by num_items desc;



-- How many orders had more than 12 items?
select count(*) from
(select order_id,count(item_id) as Num_items from restaurant_db.order_details
group by order_id
having num_items>12) as num_orders;



-- -------------------xx-------------------------- --

--
SELECT *
FROM order_details
LEFT JOIN menu_items mi ON order_details.item_id = mi.menu_item_id;

--

SELECT item_name,count(order_details_id) as num_purchases
FROM order_details
LEFT JOIN menu_items mi ON order_details.item_id = mi.menu_item_id
group by item_name
order by num_purchases;


--
SELECT item_name,category,count(order_details_id) as num_purchases
FROM order_details
LEFT JOIN menu_items mi ON order_details.item_id = mi.menu_item_id
group by item_name,category
order by num_purchases;


--
SELECT order_id,sum(price) as total_spend
FROM order_details
LEFT JOIN menu_items mi ON order_details.item_id = mi.menu_item_id
group by order_id
order by total_spend desc limit 5;




--
SELECT category,count(item_id) as total_items
FROM order_details
LEFT JOIN menu_items mi ON order_details.item_id = mi.menu_item_id
where order_id = 440
group by category;


SELECT order_id,sum(price) as total_spend
FROM order_details
LEFT JOIN menu_items mi ON order_details.item_id = mi.menu_item_id
group by order_id
order by total_spend desc;
