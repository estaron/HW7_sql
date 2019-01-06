USE sakila;

-- 1a

select first_name, last_name from actor;

-- 1b

select upper(concat(first_name, ' ', last_name)) 'Actor Name' from actor;

-- 2a 

select actor_id, first_name, last_name from actor
where first_name = "JOE";

-- 2b

select first_name, last_name from actor
where last_name like '%GEN%';

-- 2c

select last_name, first_name from actor
where last_name like '%LI%';

-- 2d

select country_id, country from country
WHERE country in ('Afghanistan', 'Bangladesh','China');

-- 3a

alter table actor
ADD column description BLOB;

-- 3b
alter table actor
drop column description;

-- 4a

select last_name, count(last_name) from actor
group by last_name;

-- 4b

select last_name, count(last_name) from actor
group by last_name
HAVING count(last_name)>1;

-- 4c

update actor
set first_name = "HARPO"
where first_name = "GROUCHO" AND last_name = 'WILLIAMS'; 

-- 4d

update actor
set first_name = "GROUCHO"
where first_name = "HARPO";

-- 5a

SHOW CREATE TABLE address;

-- 6a


select first_name,Last_name, address from staff s 
join address a 
on s.address_id=a.address_id;

--  6b

select first_name, last_name, sum(amount) from payment p
join staff s 
on s.staff_id=p.staff_id
where month(payment_date)=8
group by last_name;

-- 6c

select title, count(actor_id) from film f
join film_actor a on f.film_id = a.film_id
group by title;

-- 6d

select count(title) from inventory i
join film f on i.film_id = f.film_id
WHERE title = 'Hunchback Impossible';

-- 6e

select * from payment;

select first_name, last_name, sum(amount) from customer c
join payment p ON c.customer_id = p.customer_id
group by c.customer_id order by last_name;

-- 7a

select * from film where (title like 'Q%' OR title like 'K%')
AND language_id = (select language_id from language where name='English');

-- 7b

select first_name, last_name from actor where actor_id in(
select actor_id from film_actor where film_id = (
select film_id from film where title = 'Alone Trip'));

-- 7c

select first_name, last_name, email from customer where address_id in(
select address_id from address where city_id in (
select city_id from city where country_id in (
select country_id from country where country = 'Canada')));


-- 7d

select title from film where film_id in(
select film_id from film_category where category_id = (
select category_id from category where name = 'Family'));

-- 7e

select f.film_id, title, count(f.film_id) as 'Times Rented' from rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f on i.film_id = f.film_id
group by title
order by count(film_id) desc;


-- 7f

select staff_id as 'Store', sum(amount) from payment group by staff_id;

-- 7g

select store_id, city, country from store s join
address a ON s.address_id = a.address_id
join city c on c.city_id = a.city_id
join country ct on ct.country_id = c.country_id;

-- 7h

select c.name from rental r join payment p 
ON r.rental_id = p.rental_id
join inventory i on i.inventory_id =  r.inventory_id
join film_category fc on fc.film_id = i.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by sum(amount) desc
LIMIT 5;

-- 8a

Create VIEW Top_5_Categories as 
select c.name from rental r join payment p 
ON r.rental_id = p.rental_id
join inventory i on i.inventory_id =  r.inventory_id
join film_category fc on fc.film_id = i.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by sum(amount) desc
LIMIT 5;

-- 8b  

select * from Top_5_Categories;

-- 8c

drop view Top_5_Categories;