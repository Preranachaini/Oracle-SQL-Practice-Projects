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


-- MODERATE LEVEL QUESTIONS

-- Q6. Write a query to return the first name, last name, email, & genre of all rock music listeners. Return your list ordered alphabetically by email starting with A.

select * from track;
select * from genre;
select * from invoice_line;

select distinct customer.email, customer.first_name, customer.last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
where track.track_id in(
select track.track_id
    FROM track
    JOIN genre ON track.genre_id = genre.genre_id
    WHERE genre.name = 'Rock')
order by customer.email;


-- Q7. Inviting artists who have writtern the most rock music in the music dataset . Write a query that returns the artist name and total track count of the top 10 rock bands.

SELECT artistname.name, artistname.artist_id, COUNT(track.track_id) AS no_of_songs
FROM artistname
JOIN album ON artistname.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
GROUP BY artistname.name, artistname.artist_id
ORDER BY no_of_songs DESC;


-- Q8. Return all the track names that have a song length longer than the average song length. Return the name and the milisecounds ofor each track. Order by the song length with the longest songs listed first.
select track.name, track.milliseconds
from track where milliseconds > ( select avg(track.milliseconds) as avg_song_length from track)
order by track.milliseconds desc;




