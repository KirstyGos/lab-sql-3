USE sakila;

# 1. How many distinct (different) actors' last names are there?
SELECT COUNT(distinct last_name) #count unique last names from 'actor', answer is 121
FROM actor;

# 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(distinct language_id) #the films were produced in 1 language
FROM film;

# 3. How many movies were released with "PG-13" rating?
SELECT *
FROM film;

SELECT COUNT(rating)
FROM film
WHERE rating LIKE "PG-13"; #there are 223 films with rating PG-13

# 4. Get 10 the longest movies from 2006.
SELECT *
FROM film
WHERE release_year LIKE "2006"
ORDER BY length DESC
LIMIT 10;


# 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental; # using the first rental date vs the last rental date, the number of operating days is 266

# 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *
FROM rental;

SELECT *, substring(rental_date, 6, 2) AS month, 
CASE
	WHEN (DAYNAME(rental_date) = "Monday") THEN "Monday"
    WHEN (DAYNAME(rental_date) = "Tuesday") THEN "Tuesday"
    WHEN (DAYNAME(rental_date) = "Wednesday") THEN "Wednesday"
    WHEN (DAYNAME(rental_date) = "Thursday") THEN "Thursday"
    WHEN (DAYNAME(rental_date) = "Friday") THEN "Friday"
    WHEN (DAYNAME(rental_date) = "Saturday") THEN "Saturday"
    ELSE "Sunday"
    END AS weekday
FROM rental
LIMIT 20;

### this feels like a super overcomplicated way to do this, it worked though

# 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT  *,
CASE
	WHEN (DAYNAME(rental_date) = "Saturday" OR DAYNAME(rental_date) = "Sunday") THEN "weekend"
	ELSE "workday"
    END AS day_type
from rental;

# 8. How many rentals were in the last month of activity?
SELECT *
FROM rental
ORDER BY rental_date DESC;

SELECT rental_id, DATE_FORMAT(rental_date, "%Y-%m-%d") as date_2, datediff("2006-02-14", DATE_FORMAT(rental_date, "%Y-%m-%d")) as date_3
FROM rental
WHERE datediff("2006-02-14", DATE_FORMAT(rental_date,"%Y-%m-%d")) < 30;

### date_3 column only has '0', not sure what I missed here