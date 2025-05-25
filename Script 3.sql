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

-- Hmburger are populer so we should keep that on the menu 

-- 5. View details of the top 5  highest spend orders . what insights can you gather from the result 

select order_id, category , count(item_id) as num_items
 from
order_details od left join menu_items mi
   on od.item_id= mi.menu_item_id
where order_id in (440, 2075, 1957, 330 , 2675)
group by order_id, category;

-- insights - whe should keep this expensive Italian dishes on the menu  because they seem to be ordering that lot  
