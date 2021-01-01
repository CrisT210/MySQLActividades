-- 9. Self join

/*
1. Summary
How many stops are in the database.
*/
SELECT COUNT(*) AS stops FROM stops;

/*
2. 
Find the id value for the stop 'Craiglockhart'
*/
SELECT id FROM stops
WHERE name = 'Craiglockhart';

/*
3.
Give the id and the name for the stops on the '4' 'LRT' service.
*/
SELECT s.id, s.name 
FROM stops AS s
INNER JOIN route AS r ON (r.stop = s.id) 
WHERE r.num = 4  
AND company = 'LRT'
ORDER BY r.pos;

-- Routes and stops

/*
4.  The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes.
*/
SELECT company, num, COUNT(*)
FROM route 
WHERE (stop = 149 OR stop = 53)
GROUP BY company, num
HAVING COUNT(*) = 2;

/*
5. 
Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. 
Change the query so that it shows the services from Craiglockhart to London Road.
*/
SELECT a.company, a.num, a.stop, b.stop
FROM route AS a 
INNER JOIN route AS b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 
AND b.stop = (SELECT id FROM stops 
              WHERE name = 'London Road');
              
/*
6.
The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. 
Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
If you are tired of these places try 'Fairmilehead' against 'Tollcross'
*/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route AS a 
INNER JOIN route AS b ON (a.company=b.company AND a.num=b.num)
INNER JOIN stops stopa ON (a.stop=stopa.id)
INNER JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' 
AND stopb.name = 'London Road';

-- Using a self join

/*
7.
Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
*/
SELECT DISTINCT r1.company, r1.num
FROM route AS r1, route AS r2
WHERE r1.company = r2. company
AND r1.num = r2.num
AND r1.stop = 115 
AND r2.stop = 137;

/*
8.
Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
*/
SELECT r1.company, r1.num
FROM route AS r1, route AS r2
WHERE r1.company = r2. company
AND r1.num = r2.num
AND r1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart') 
AND r2.stop = (SELECT id FROM stops WHERE name = 'Tolcross');

/*
9.
Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, 
including 'Craiglockhart' itself, offered by the LRT company. 
Include the company and bus no. of the relevant services.
*/
SELECT s.name, r1.company, r1.num
FROM route AS r1, route AS r2, stops AS s
WHERE r1.company = r2. company
AND r1.num = r2.num
AND r2.stop = s.id
AND r1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart');

/*
10. 
Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.
*/
SELECT r1.num, r1.company, s.name, r3.num, r3.company
FROM route AS r1, route AS r2, route AS r3, route AS r4, stops AS s
WHERE r1.company = r2. company
AND r1.num = r2.num
AND r3.company = r4. company
AND r3.num = r4.num
AND r2.stop = r4.stop 
AND r2.stop = s.id
AND r1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
AND r3.stop = (SELECT id FROM stops WHERE name = 'Lochend')
ORDER BY r1.num, s.name, r3.num;
