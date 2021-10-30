-- Step 1 : Create a Database
CREATE DATABASE stack;

-- Step 2 : Creating a table to store the processed data set.
create table stackex (id int, postId int , ansId int , score int , view int , body string , userId int , userName string , title string) ROW format delimited FIELDS TERMINATED BY ',' TBLPROPERTIES("skip.header.line.count"="1") ;

-- Step 3 : Loading the exported data csv into the hive table.
load data inpath '/assignment/assignment.csv' into table stackex;

--  3(1) :  To fetch the top 10 posts by score from the table.
SELECT id, title, score FROM stackex ORDER BY score DESC LIMIT 10;

--  3(2) : The top 10 users by post score from the table.
SELECT userId, SUM(score) AS totalscore FROM stackex GROUP BY userId ORDER BY totalscore DESC LIMIT 10;

-- 3(3) : The number of distinct users, who used the word "cloud" in one of their posts in the title or in the body.
SELECT COUNT (DISTINCT userId) FROM stackex WHERE (LOWER(title) LIKE '%cloud%' OR LOWER(body) LIKE '%cloud%');