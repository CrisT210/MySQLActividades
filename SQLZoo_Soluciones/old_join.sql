-- Old Join Tutorial

/*
1. Summary
Show the athelete (who) and the country name for medal winners in 2000.
*/
SELECT who, country.name
FROM ttms JOIN country ON (ttms.country=country.id)
WHERE games = 2000;

/*
2. 
Show the who and the color of the medal for the medal winners from 'Sweden'.
*/
SELECT t.who, t.color
FROM ttms AS t
INNER JOIN country AS c ON c.id = t.country
WHERE c.name = 'Sweden';

/*
3.
Show the years in which 'China' won a 'gold' medal.
*/
SELECT t.games
FROM country AS c
INNER JOIN ttms AS t ON t.country = c.id
WHERE c.name = 'China' AND t.color = 'Gold';

-- Women's Singles Table Tennis Olympics Database

/*
4. 
Show who won medals in the 'Barcelona' games.
*/
SELECT t.who
FROM ttws AS t 
INNER JOIN games AS g ON t.games = g.yr
WHERE city = 'Barcelona';

/*
5. 
Show which city 'Jing Chen' won medals. Show the city and the medal color.
*/
SELECT g.city, t.color
FROM games AS g
INNER JOIN ttws AS t ON t.games = g.yr
WHERE t.who = 'Jing Chen';

/*
6.
Show who won the gold medal and the city.
*/
SELECT t.who, g.city
FROM games AS g
INNER JOIN ttws AS t ON t.games = g.yr
WHERE t.color = 'Gold';

-- Table Tennis Mens Doubles

/*
7.
Show the games and color of the medal won by the team that includes 'Yan Sen'.
*/
SELECT tt.games, tt.color
FROM team AS t
INNER JOIN ttmd AS tt ON tt.team = t.id
WHERE name = 'YAN SEN';

/*
8.
Show the 'gold' medal winners in 2004.
*/
SELECT t.name FROM team AS t
INNER JOIN ttmd AS tt ON tt.team = t.id
WHERE tt.games = 2004 AND tt.color = 'Gold';

/*
9.
Show the name of each medal winner country 'FRA'.
*/
SELECT t.name FROM team AS t
INNER JOIN ttmd AS tt ON tt.team = t.id
WHERE tt.country = 'FRA';



