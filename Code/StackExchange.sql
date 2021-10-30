-- https://data.stackexchange.com/stackoverflow/query/

-- Queries to extract top 200000 rows based on most ViewCount

-- Dataset 1 
select top 50000 * from Posts where ViewCount < 10030837 order by Posts.ViewCount desc ;

-- Dataset 2 
select top 50000 * from Posts where ViewCount < 127758 AND ViewCount >= 72000 order by Posts.ViewCount DESC ;

-- Dataset 3 
select top 50000 * from Posts where ViewCount < 74790 AND ViewCount >= 50000 order by Posts.ViewCount DESC;

-- Dataset 4 
select top 50000 * from Posts where ViewCount < 53348 AND ViewCount >= 40000 order by Posts.ViewCount DESC ;