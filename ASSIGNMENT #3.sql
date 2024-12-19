-- Created By: Navjot Singh
-- Date: March 17, 2024


/* 1.	Create an SQL statement that adds yourself to the Players table.  Use your real first and last names, 
your real dob, and use your studentID as the regNumber.  Make yourself active and use a playerID of your own choice. */

UPDATE players 
SET regnumber = '100931376',
    lastname = 'Singh',
    firstname = 'Navjot',
    isactive = 1,
    dob = '2004-09-29'
WHERE playerid = 9999;

/* 2.	Create an SQL statement that change your professor’s (whom is a player in the database) dob to be May 16, 1992. */

UPDATE players
SET dob = '1992-05-16'
WHERE lastname = 'Brian' AND firstname = 'Kelly';

/* 3.	Create a statement that adds both yourself and your professor to the team called “Noobs” making yourself active and 
your professor not active.  Choose a jersey number for yourself and use number 16 for your prof. */ 

INSERT INTO rosters (playerid, teamid, isactive, jerseynumber)
VALUES (9999, (SELECT teamid FROM teams WHERE teamname = 'Noobs'), 1, 5);

INSERT INTO rosters (playerid, teamid, isactive, jerseynumber)
VALUES ((SELECT playerid FROM players WHERE lastname = 'Brian' AND firstname = 'Kelly'), 
        (SELECT teamid FROM teams WHERE teamname = 'Noobs'), 0, 16);

/* 4.	Create a query that outputs the team roster for all active teams in the league.  Include the player names, 
jersey number, and team name in each row, making sure that players on the same team are together in the output, 
further sorted by last name, then by first name. */

SELECT t.teamname AS TeamName, 
       p.lastname AS LastName, 
       p.firstname AS FirstName, 
       r.jerseynumber AS JerseyNumber
FROM teams t
INNER JOIN rosters r ON t.teamid = r.teamid
INNER JOIN players p ON r.playerid = p.playerid
WHERE p.isactive = 1
ORDER BY t.teamname, p.lastname, p.firstname;

/* 5.	Create a query that outputs the league schedule (game number, date, both team names, and location name)
for all future games, or games not yet played.  Sort the output in ascending chronological order.  Use JOIN and not sub-queries. */

SELECT g.Gamenum AS GameNumber,
       g.gamedatetime AS GameDate,
       home.teamname AS HomeTeamName,
       visit.teamname AS VisitTeamName,
       l.locationname AS LocationName
FROM games g
INNER JOIN teams home ON g.hometeam = home.teamid
INNER JOIN teams visit ON g.visitteam = visit.teamid
INNER JOIN locations l ON g.locationid = l.locationid
WHERE g.Isplayed = 0 
ORDER BY g.gamedatetime ASC;

/* 
6.	Repeat Question 5, but use sub-queries to obtain the team names, rather than JOINS. 
You may still use JOINS for other output if required.  Note: you should obtain the exact same output in Q5 and Q6. */

SELECT g.Gamenum AS GameNumber,
       g.gamedatetime AS GameDate,
       (SELECT teamname FROM teams WHERE teamid = g.hometeam) AS HomeTeamName,
       (SELECT teamname FROM teams WHERE teamid = g.visitteam) AS VisitTeamName,
       l.locationname AS LocationName
FROM games g
INNER JOIN locations l ON g.locationid = l.locationid
WHERE g.Isplayed = 0 
ORDER BY g.gamedatetime ASC;

/* 7.	Take the statement from either Q5 or Q6 and store it in the database as a view, called vwFutureGames. 
Then create a query that uses the view to output the exact same results, including sorting.*/
-- Create the view and immediately query it
-- Create the view and immediately query it
WITH vwFutureGames AS (
    SELECT g.Gamenum AS GameNumber,
           g.gamedatetime AS GameDate,
           home.teamname AS HomeTeamName,
           visit.teamname AS VisitTeamName,
           l.locationname AS LocationName
    FROM games g
    INNER JOIN teams home ON g.hometeam = home.teamid
    INNER JOIN teams visit ON g.visitteam = visit.teamid
    INNER JOIN locations l ON g.locationid = l.locationid
    WHERE g.Isplayed = 0
)
SELECT *
FROM vwFutureGames
ORDER BY GameDate ASC;

/* 8.	Create a query that outputs the names of the soccer fields (locations) in the database that have never been assigned
a game within the league. You may NOT use JOINS or Sub-Queries in the main statement, but you may use a sub-query to obtain the names afterwards.*/

CREATE TABLE #AssignedLocations (
    locationid INT PRIMARY KEY
);

INSERT INTO #AssignedLocations (locationid)
SELECT DISTINCT locationid
FROM games
WHERE locationid IS NOT NULL; 

SELECT locationname
FROM locations
WHERE locationid NOT IN (SELECT locationid FROM #AssignedLocations);

DROP TABLE #AssignedLocations;

/* 9. Repeat Question 8 using JOINS and NOT set operators. */

SELECT l.locationname
FROM locations l
LEFT JOIN games g ON l.locationid = g.locationid
WHERE g.locationid IS NULL;

/* 10.	Create a query that outputs the number of games each team has played as the home team and
how many games they have played as the away team as of today.  You may assume that the isPlayed field is up to date.
A sample of the output might look like this:
TEAMID		TEAMNAME	HOMEGAMES	AWAYGAMES
1		    kickers			5		6
2        	wannabees      	4       6
...... */

SELECT 
    t.teamid AS TeamID,
    t.teamname AS TeamName,
    SUM(CASE WHEN g.hometeam = t.teamid THEN 1 ELSE 0 END) AS HomeGames,
    SUM(CASE WHEN g.visitteam = t.teamid THEN 1 ELSE 0 END) AS AwayGames
FROM 
    teams t
LEFT JOIN 
    games g ON t.teamid = g.hometeam OR t.teamid = g.visitteam
GROUP BY 
    t.teamid, t.teamname;