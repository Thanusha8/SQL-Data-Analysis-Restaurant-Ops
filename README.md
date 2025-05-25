# SQL-Data-Analysis-Restaurant-Ops
Analyzes new menu performance and customer preferences at Taste of the World Cafe.


## Project Objective
Evaluate customer reactions to the new menu by analyzing order patterns, identifying top-performing items, and uncovering trends to guide menu optimization and marketing strategies.




## Script 01  - Analyze menu composition, pricing, and category distribution to understand item variety and cost structure.

use restaurant_db;

-- 1. View the menu_items table.

select * from menu_items;



-- 2. Find the number of items on the menu 

select count(*) from menu_items;



-- 3. What are the least and most expensive items on the menu 

select * from menu_items
order by price;

select * from menu_items
order by price desc;



-- 4. How many Italian dishes are on the menu 

select count(*) from menu_items
where category="Italian";



-- 5. what are the least and most expensive Italian dishes on the menu 

Select * from menu_items
where category="Italian"
order by price;

Select * from menu_items
where category="Italian"
order by price desc;



-- 6. How many dishes are in each category

select category, count(menu_item_id) as num_dishes 
from menu_items 
group by category;



-- 7. what is the average dish price within each category 

select category, avg(price) as avg_price
from menu_items
group by category;




## Script 02  - Examine order frequency, item quantities, and large orders to gauge customer purchasing patterns.

use restaurant_db;

-- 1. Vieew the order details table

select * from order_details;

-- 2. what is the date rnge of the table 

select min(order_date), max(order_date)
from order_details;

-- 3. How many orders were made within this date rang 

select count(distinct order_id) from order_details;

-- 4. How many items were ordered within this date range 

select count(*) from order_details;

-- 5.which orders had the most number of items 

select order_id,count(order_id) as num_items
 from order_details
group by order_id
order by num_items desc;

-- 6. How many orders had more than 1 items 

Select count(*) from

(select order_id,count(order_id) as num_items
 from order_details
group by order_id
having num_items >12) as num_orders;


 ## Script 03  - Identify top/least ordered items and high-spend orders to reveal popular dishes and spending habits.


 use restaurant_db;

-- 1. Combine the menu_items and order_details tables into a single table 

select * from menu_items;
select * from order_details;

select * from
order_details od left join menu_items mi
   on od.item_id= mi.menu_item_id;
   
-- 2. what were the least and most ordered items? what categories were they in?

select item_name,category ,  count(order_details_id) as num_purchses 
from
order_details od left join menu_items mi
   on od.item_id= mi.menu_item_id
   group by item_name , category
   order by num_purchses desc;
   
-- 3. what are the top 5 orders that spent the most money

select order_id, sum(price) as total_spend from
order_details od left join menu_items mi
   on od.item_id= mi.menu_item_id
   group by order_id
   order by total_spend desc
   limit 5;
   
-- 4. view the details of the highest spend order. what insights can you gather from the result

select category , count(item_id) as num_items
 from
order_details od left join menu_items mi
   on od.item_id= mi.menu_item_id
where order_id=440
group by category;

-- Hamburgers are popular, so we should keep them on the menu.


-- 5. View details of the top 5  highest spend orders . what insights can you gather from the result 

select order_id, category , count(item_id) as num_items
 from
order_details od left join menu_items mi
   on od.item_id= mi.menu_item_id
where order_id in (440, 2075, 1957, 330 , 2675)
group by order_id, category;

-- insights - We should keep these expensive Italian dishes on the menu because they seem very popular. 

