-- 5. The JOIN operation

/*
1. 
Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
*/
SELECT matchid, player FROM goal 
WHERE teamid = 'GER';

/*
2.
Show id, stadium, team1, team2 for just game 1012
*/
SELECT id,stadium,team1,team2 FROM game
WHERE id = (
	SELECT matchid FROM goal 
    WHERE player LIKE '%Bender');
    
/*
3. 
Modify it to show the player, teamid, stadium and mdate for every German goal.
*/
SELECT go.player, go.teamid, ga.stadium, ga.mdate
FROM game AS ga
JOIN goal AS go ON ga.id = go.matchid
WHERE go.teamid = 'GER';

/*
4. 
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/
SELECT ga.team1, ga.team2, go.player
FROM game AS ga
JOIN goal AS go ON ga.id = go.matchid
WHERE go.player LIKE 'Mario%';

/*
5.
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/
SELECT go.player, e.id, e.coach, go.gtime
FROM goal AS go
JOIN eteam AS e ON e.id = go.teamid
WHERE go.gtime <= 10;

/*
6.
List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/
SELECT ga.mdate, e.teamname
FROM eteam AS e
JOIN game AS ga ON ga.team1 = e.id
WHERE e.coach = 'Fernando Santos';

/*
7.
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/
SELECT go.player
FROM game AS ga
JOIN goal AS go ON go.matchid = ga.id
WHERE stadium = 'National Stadium, Warsaw';

/*
8. 
Instead show the name of all players who scored a goal against Germany.
*/
SELECT DISTINCT go.player
FROM game AS ga
JOIN goal AS go ON go.matchid = ga.id
WHERE (ga.team1 = 'GER' OR ga.team2 = 'GER') AND go.teamid != 'GER';

/*
9.
Show teamname and the total number of goals scored.
*/
SELECT e.teamname, COUNT(go.matchid) AS goals_scored
FROM goal AS go
JOIN eteam AS e ON e.id = go.teamid
GROUP BY e.teamname; 

/*
10.
Show the stadium and the number of goals scored in each stadium.
*/
SELECT ga.stadium, COUNT(go.matchid) AS goals_scored
FROM goal AS go
JOIN game AS ga ON ga.id = go.matchid
GROUP BY ga.stadium;

/*
11.
For every match involving 'POL', show the matchid, date and the number of goals scored.
*/
SELECT ga.id, ga.mdate, COUNT(go.matchid) AS golas_scored
FROM goal AS go
JOIN game AS ga ON go.matchid = ga.id
WHERE (ga.team1 = 'POL' OR ga.team2 = 'POL')
GROUP BY ga.id, ga.mdate;

/*
12.
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
*/
SELECT go.matchid, ga.mdate, COUNT(go.matchid) AS golas_scored
FROM goal AS go
JOIN game AS ga ON go.matchid = ga.id
WHERE (ga.team1 = 'GER' OR ga.team2 = 'GER') AND go.teamid = 'GER'
GROUP BY go.matchid, ga.mdate;

/*
13.
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
*/
SELECT ga.mdate, 
	ga.team1, SUM(CASE WHEN go.teamid = ga.team1 THEN 1 ELSE 0 END) AS score1 , 
    ga.team2, SUM(CASE WHEN go.teamid = ga.team2 THEN 1 ELSE 0 END) AS score2
FROM game AS ga
LEFT JOIN goal AS go ON go.matchid = ga.id
GROUP BY ga.mdate, ga.team1, ga.team2
ORDER BY ga.mdate, ga.id

