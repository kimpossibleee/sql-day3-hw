SELECT * FROM customer; 

--EXERCISE 1: List all customers who live in Texas
SELECT first_name, last_name, district
FROM customer 
JOIN address ON customer.address_id = address.address_id
WHERE district = 'Texas';

--Exercise 2: Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM payment 
JOIN customer ON customer.customer_id = payment.customer_id  
WHERE amount > 6.99;

--Exercise 2.1: Here I grouped amount by customers from Exercise 2, and ordered by highest -> lowest
SELECT payment.customer_id, first_name, last_name, sum(amount) AS total FROM payment 
JOIN customer ON customer.customer_id = payment.customer_id  
WHERE amount > 6.99
GROUP BY payment.customer_id, first_name, last_name
ORDER BY total DESC ;

--Exersise 3: Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name
FROM customer WHERE customer_id in(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id 
	HAVING sum(amount) > 175
);

--Exercise 4: List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country FROM customer
JOIN address ON customer.address_id = address.address_id 
JOIN city ON address.city_id = city.city_id 
JOIN country ON country.country_id = city.city_id
WHERE country = 'Nepal'
;

--Exercise 5: Which staff member had the most transactions?
SELECT first_name, last_name
FROM staff WHERE staff_id in(
	SELECT staff_id
	FROM payment 
	GROUP BY staff_id
	ORDER BY count(staff_id) DESC 
	LIMIT 1
);

--Exercise 6: How many movies of each rating are there? 
SELECT rating, count(rating) FROM film
GROUP BY rating 
ORDER BY count(rating) DESC;

--Exercise 7: Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer WHERE customer_id IN (
	SELECT DISTINCT customer_id
	FROM payment 
	WHERE amount > 6.99 
);

--Exercise 7.1: Wasn't entirely sure if this was a trick question, but there were no customers who made exactly one single transaction. In the case of our database, it would conclude to 0 customers
SELECT first_name, last_name
FROM customer WHERE customer_id IN(
	SELECT customer_id FROM payment
	GROUP BY customer_id 
	HAVING count(amount) = 1
);

SELECT customer_id, count(amount) FROM payment 
GROUP BY customer_id 
HAVING count(amount) < 1

--Exercise 8: How many free rentals did our stores give away?
SELECT count(amount) FROM payment 
GROUP BY amount
HAVING amount = 0;

--Exercise 8.1: List ALL the films that were free rentals
SELECT title, amount FROM film
JOIN inventory ON inventory.film_id = film.film_id 
JOIN rental ON rental.inventory_id = inventory.inventory_id 
JOIN payment ON payment.rental_id = rental.rental_id 
WHERE amount = 0;


