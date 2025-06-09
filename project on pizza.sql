CREATE DATABASE Pizzahut;

SELECT * FROM pizzahut.pizzas;

SELECT * FROM pizzahut.pizza_types;

CREATE TABLE orders(
order_id INT NOT NULL,
order_date date not null,
Order_time time not null,
primary key (order_id));

select* FROM pizzahut.orders;

CREATE TABLE order_details(
order_detail_id INT NOT NULL PRIMARY KEY,
order_id INT NOT NULL,
pizza_id VARCHAR(50) NOT NULL,
quantity int NOT NULL
);

SELECT * FROM pizzahut.order_details;


SELECT * from orders;

SELECT count(order_id) as total_orders from orders;


SELECT sum(price) FROM pizzas;

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id




SELECT pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_type.pizza_type_id = pizzas.pizza_type_id;










SELECT pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;




SELECT quantity, count(order_detail_id)
from order_details group by quantity;


SELECT 
    pizzas.size,
    COUNT(order_details.order_detail_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;




SELECT 
    pizza_types.name, SUM(order_details.quantity) AS Qty
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Qty DESC
LIMIT 5; 





SELECT 
    pizza_types.category, SUM(order_details.quantity) AS QTY
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY QTY DESC;




SELECT 
    HOUR(Order_time) as hour, COUNT(order_id) as order_count
FROM
    orders
GROUP BY HOUR(Order_time);




SELECT category , count(name) from pizza_types
GROUP BY category;




SELECT 
    ROUND(AVG(Qty), 0) as avg_pizza_ordered
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS Qty
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;




SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


SELECT pizza_types.category,
ROUND(sum(order_details.quantity * pizzas.price)/ (SELECT
ROUND(sum(order_details.quantity * pizzas.price),2) AS total_sales
FROM order_details join pizzas 
on pizzas.pizza_id = order_details.pizza_id)*100, 2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc; 







SELECT order_date,
sum(revenue) over (order by order_date) as cum_revenue
FROM
(SELECT orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
GROUP BY orders.order_date) as sales;







SELECT name, revenue FROM
(SELECT category , name , revenue,
RANK() OVER(partition by category order by revenue desc) as rn
from
(SELECT pizza_types.category, pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
WHERE rn <=3;


selec






