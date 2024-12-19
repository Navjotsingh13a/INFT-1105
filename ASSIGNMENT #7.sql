/*
Author: Navjot Singh and Sarabhjodh Singh Baweja
Date: March 24, 2024
Course: INFT 1105
Purpose: Class Activity 7
*/


/* 1. Use the NOT IN clause and a subquery to create a list of all composers who do not have any records
in the songs table. Include only the composer name column in your result, but give this column an appropriate name. */ 

SELECT ComposerName AS Unrecorded_Composers
FROM Composer
WHERE ComposerID NOT IN (SELECT DISTINCT ComposerID FROM Song);

/* 2. List songs and cost that are higher than the average cost, order by song names. Hint: You will need to use a subquery.*/

SELECT SongName, Cost
FROM Song
WHERE Cost > (SELECT AVG(Cost) FROM Song)
ORDER BY SongName;

/* 3 a) Use a JOIN and a subquey to display artist name, song name, and cost.*/

SELECT a.ArtistName, s.SongName, s.Cost
FROM Artist a
JOIN (
    SELECT SongName, Cost, ArtistID
    FROM Song
) AS s ON a.ArtistID = s.ArtistID;

/* b) Do the same thing but only use a JOIN. */

SELECT a.ArtistName, s.SongName, s.Cost
FROM Song s
JOIN Artist a ON s.ArtistID = a.ArtistID;
