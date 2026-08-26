/* 1. Which customer generated the highest revenue? */

SELECT customer.customer_id,customer.first_name,customer.last_name,
ROUND(SUM(invoice.total)::numeric,2) AS total
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1

/* Business Insight->Identifies the highest-value customer, helping the business focus on customer retention and loyalty strategies.*/


/* 2. Number of Customers by Country */

SELECT DISTINCT country,COUNT(customer_id) 
AS customer_count FROM customer
GROUP BY country
ORDER BY customer_count DESC

/* Business Insight->It helps the business understand where most of its customers are located and which countries have the largest customer base.*/


/* 3. Who is the Junior most employee based on job title? */

SELECT *  
FROM employee
ORDER BY levels ASC
LIMIT 1

/* Business Insight->It helps the business understand the employee hierarchy and identify the most junior employee.*/


/* 4. How much revenue is generated from each country, and which countries generate the highest revenue? */

SELECT 
billing_country AS Country,
ROUND(SUM(total)::numeric, 2) AS Revenue
FROM invoice
GROUP BY billing_country
ORDER BY Revenue DESC

/* Business Insight->It helps the business identify which countries are generating the most revenue and where sales are strongest.*/


/* 5. Which 5 tracks have been purchased the most? */

SELECT track.name AS track_name,SUM(invoice_line.quantity) AS total_purchase
FROM track
JOIN invoice_line ON track.track_id=invoice_line.track_id
GROUP BY track_name
ORDER BY total_purchase DESC 
LIMIT 5

/* Business Insight->It helps the business identify the most popular tracks and understand what customers are buying the most.*/


/* 6. For each customer, how many purchases have they made and how much have they spent in total? */

SELECT customer.customer_id,customer.first_name,customer.last_name,COUNT(*) 
AS total_purchase,ROUND(SUM(invoice.total)::numeric,2) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id,customer.first_name,customer.last_name
ORDER BY total_spent DESC

/* Business Insight->It helps the business understand which customers buy more often and spend more, making it easier to focus on valuable customers.*/


/* 7. Which artists have the most albums? */

SELECT 
artist.name AS artist_name,
COUNT(album.album_id) AS total_albums
FROM artist
JOIN album 
ON artist.artist_id = album.artist_id
GROUP BY artist.name
ORDER BY total_albums DESC
LIMIT 1

/* Business Insight->It helps the business understand which artists have the largest music catalog and the strongest presence in the store.*/


/* 8. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.*/

SELECT DISTINCT email,first_name,last_name 
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
WHERE track_id 
      IN(
      SELECT track_id from track
      JOIN genre ON track.genre_id=genre.genre_id
      WHERE genre.name LIKE 'Rock'
      )
ORDER BY email

/* Business Insight->It helps the business identify customers interested in Rock music, which can be useful for targeted offers and recommendations.*/


/* 9. Let's invite the artists who have written the most Jazz music in our dataset. Write a query that returns the Artist name and total track count of the top 10 Jazz music.*/

SELECT artist.name,COUNT(artist.artist_id) AS track_count
FROM track
JOIN album ON track.album_id=album.album_id
JOIN artist ON album.artist_id=artist.artist_id
JOIN genre ON track.genre_id=genre.genre_id
WHERE genre.name LIKE 'Jazz'
Group BY artist.artist_id
ORDER BY track_count DESC
LIMIT 10

/* Business Insight->It helps the business identify which artists are most active in Jazz and understand the strongest contributors to its Jazz music collection.*/


/* 10. Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.*/

SELECT name,milliseconds 
FROM track
WHERE milliseconds>(
SELECT AVG(milliseconds) AS avg_milliseconds FROM track
)
ORDER BY milliseconds DESC

/* Business Insight->It helps the business identify longer-than-average tracks and understand the characteristics of the music in its catalog.*/






