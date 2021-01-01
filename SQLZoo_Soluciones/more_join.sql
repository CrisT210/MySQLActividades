-- 7. More JOIN operations

/*
1. 1962 movies
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
FROM movie
WHERE yr=1962;

/*
2. When was Citizen Kane released?
Give year of 'Citizen Kane'.
*/
SELECT yr FROM movie
WHERE title = 'Citizen Kane';

/*
3. Star Trek movies
*/
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

/*
4. id for actor Glenn Close
What id number does the actor 'Glenn Close' have?
*/
SELECT id FROM actor
WHERE name = 'Glenn Close';

/*
5. id for Casablanca
What is the id of the film 'Casablanca'
*/
SELECT id FROM movie
WHERE title = 'Casablanca';

/*
6. Cast list for Casablanca
Obtain the cast list for 'Casablanca'.
what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/
SELECT a.name FROM actor AS a
INNER JOIN casting AS c ON c.actorid = a.id
INNER JOIN movie AS m ON m.id = c.movieid
WHERE c.movieid = (SELECT id FROM movie
					WHERE title = 'Casablanca'); 
                    
/*
7. Alien cast list
Obtain the cast list for the film 'Alien'
*/
SELECT a.name FROM actor AS a
INNER JOIN casting AS c ON c.actorid = a.id
INNER JOIN movie AS m ON m.id = c.movieid
WHERE m.title = 'Alien'; 

/*
8. Harrison Ford movies
List the films in which 'Harrison Ford' has appeared
*/
SELECT m.title FROM movie AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Harrison Ford'; 

/*
9. Harrison Ford as a supporting actor
List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT m.title FROM movies AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid
WHERE c.ord != 1
AND a.name = 'Harrison Ford';

/*
10. Lead actors in 1962 movies
List the films together with the leading star for all 1962 films.
*/
SELECT m.title, a.name
FROM movie AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid
WHERE m.yr = 1962 
AND c.ord = 1;

-- Harder Questions

/*
11. Busy years for Rock Hudson
Which were the busiest years for 'Rock Hudson', 
show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT m.yr, COUNT(m.title) AS amount_films
FROM movies AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid
WHERE a.name = 'Rock Hudson'
GROUP BY m.yr
HAVING amount_films > 2;

/*
12. Lead actor in Julie Andrews movies
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/
SELECT m.title, a.name 
FROM movie AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid 
WHERE c.ord = 1 
AND c.movieid IN (SELECT c.movieid FROM casting AS c
					INNER JOIN actor AS a ON a.id = c.actorid
					WHERE a.name = 'Julie Andrews');
                                       
SELECT m.title, a.name 
FROM movie AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid 
WHERE c.ord = 1 
AND c.movieid IN (SELECT movieid FROM casting 
					WHERE actorid = (SELECT id FROM actor
									   WHERE name = 'Julie Andrews'));
                                       
/*
13. Actors with 15 leading roles
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/
SELECT a.name
FROM casting AS c 
INNER JOIN actor AS a ON a.id = c.actorid
WHERE c.ord = 1
GROUP BY a.name
HAVING COUNT(c.ord) >= 15; 

/*
14. 
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/
SELECT m.title, COUNT(c.actorid)
FROM movie AS m
INNER JOIN casting AS c ON c.movieid = m.id
WHERE m.yr = 1978 
GROUP BY m.title
ORDER BY COUNT(c.actorid) DESC, m.title;                      

/*
15. 
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT a.name FROM actor AS a
INNER JOIN casting AS c ON c.actorid = a.id
WHERE a.name != 'Art Garfunkel'
AND c.movieid IN (SELECT movieid FROM casting
					WHERE actorid = (SELECT id FROM actor
									 WHERE name = 'Art Garfunkel'));