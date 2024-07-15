-- Q1. Who is the senior most employee based on the jon title?

select * from employee1 where levels = (select max(levels) from employee1);
 
         -- it can be writtern in this way also; 
SELECT * FROM (    
    SELECT * FROM employee1 ORDER BY levels DESC) WHERE ROWNUM = 1;
    

-- Q2. Which country has the most invoices ?

select billing_country, invoice_count from(     -- This will show you only one country as answer since we have used ronum = 1 as command for to get the hhighest invoiced countyr.
select billing_country, count(*) as invoice_count
from invoice 
group by billing_country 
order by invoice_count desc) 
where rownum = 1;

SELECT billing_country, invoice_count
FROM (
    SELECT billing_country, COUNT(*) AS invoice_count    -- This will show you list of the countries as answer, since we have used desc as command for to get the hhighest to lowest invoiced country.
    FROM invoice
    GROUP BY billing_country
    ORDER BY invoice_count DESC
);


-- Q3. What are the TOP 3 values of the total invoice ?

select * from(
select * from invoice order by total desc)
where rownum <= 3;


-- Q4. Which city has the best customers? we would kike to throw a promotional music fest in the city that has made the most of the money. write a query that returns one city that hs the highest sum of invoice totals. Returns both city name & sums of the all invoice totals?

select billing_city, invoice_c, invoice_total from (
select count(*) as invoice_c, billing_city, sum(invoice.total) as invoice_total
from invoice
group by billing_city
order by invoice_total desc)
where rownum <=5;


-- Q5. Who is the best customer? the customer who had spent his most of the money will be declared the best customer. Write a query that returns the person who has spent the most money.

select * from customer;
select * from invoice;

select customer.first_name, customer.last_name, customer.customer_id, sum(invoice.total) as total from customer 
join invoice on customer.customer_id = Invoice.customer_id
group by customer.customer_id, customer.first_name, customer.last_name
order by total desc;

--- To get the TOP 5 customers who spent the hightest value of the money.
SELECT first_name, last_name, customer_id, total
FROM (
    SELECT customer.first_name, customer.last_name, customer.customer_id, SUM(invoice.total) AS total
    FROM customer
    JOIN invoice ON customer.customer_id = invoice.customer_id
    GROUP BY customer.customer_id, customer.first_name, customer.last_name
    ORDER BY total DESC
)
WHERE ROWNUM <= 5;



