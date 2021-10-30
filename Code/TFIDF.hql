-- Step 4 : Calculate TF / IDF 

-- Install Hivemall for performing TF / IDF , download the jar file with dependencies and upload the files to the gcp vm instance.
-- The commands for installing hivemall have been listed below.

hive;
add jar /home/hitesh_wattabyte/hivemall-core-0.4.2-rc.2-with-dependencies.jar;
source /home/hitesh_wattabyte/define-all_(1).hive;


create temporary macro max2(x INT, y INT) if(x>y,x,y);

create temporary macro tfidf(tf FLOAT, df_t INT, n_docs INT) tf * (log(10, CAST(n_docs as FLOAT)/max2(1,df_t)) + 1.0);

create table distOwnerIDs as SELECT userId, SUM(score) AS TotalScore FROM stackex GROUP BY userId ORDER BY TotalScore DESC LIMIT 10;

create table mainUSRData as Select HT.userId,title from stackex  HT JOIN distOwnerIDs DO on  HT.userId = DO.userId

create or replace view mainUSRView as select userId, eachword from mainUSRData LATERAL VIEW explode(tokenize(title, True)) t as eachword where not is_stopword(eachword);

create or replace view tempView as select userId, eachword, freq from (select userId, tf(eachword) as word2freq from mainUSRView group by userId) t LATERAL VIEW explode(word2freq) t2 as eachword, freq;

create or replace view tfFinalView as select * from (select userId, eachword, freq,rank()  over (partition by UserId order by freq desc) as rn from tempView as t) as t where t.rn<=10 ;

select * from tfFinalView;  