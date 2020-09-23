-- For Non Partition tables
SELECT 			SUBSTR(B.NAME,1,18) "TABLE"
			,	A.PARTITION "PARTITION"
			,	CHAR(DECIMAL((ROUND(DEC(SPACE,8,0)/1048576,2)),4,2)) "SPACE GB"
			,	SUBSTR(CHAR((DECIMAL((ROUND(DEC(SPACE,8,0)/1048576,2)),4,2))*100/64),7,5) "PERCENTAGE"
			,	CHAR(A.CARD) "RECORDS"                                          
 			,	A.STATSTIME  "STATSTIME"                                                       
  FROM SYSIBM.SYSTABLEPART A, SYSIBM.SYSTABLES B                       
  WHERE B.CREATOR IN ('')      -- update the schema of tables                                 
  --AND A.SPACE >= 8388608                                               
  AND A.PARTITION = 0                                                  
  AND A.TSNAME = B.TSNAME                                              
  AND A.DBNAME = B.DBNAME                                              
  AND B.TYPE <> 'V'
  order by PERCENTAGE desc,"SPACE GB" DESC;
  
  -- For Partitioned tables
  SELECT 		SUBSTR(B.NAME, 1, 18) AS TABLE
		, 	A.PARTITION "PARTITION"
		, 	SUBSTR(A.LIMITKEY, 1, 16) as LIMITKEY
		,	CHAR(DECIMAL((ROUND(DEC(A.SPACE, 8, 0) / 1048576, 2)), 4, 2)) "SPACE GB"
		, 	(DECIMAL((ROUND(DEC(A.SPACE, 8, 0) / 1048576, 2)), 4, 2)/decimal(C.DSSIZE/1048576)) * 100 "PERCENTAGE"
		, 	C.DSSIZE
		,  	CHAR(A.CARD)	"RECORDS"
		,	A.STATSTIME
FROM SYSIBM.SYSTABLEPART AS A, SYSIBM.SYSTABLES AS B, SYSIBM.SYSTABLESPACE AS C
WHERE B.CREATOR IN 	('')  -- uPdate schema or owner here 
AND A.SPACE >= 2097152
AND A.PARTITION <> 0
AND A.TSNAME = B.TSNAME
AND A.TSNAME = C.NAME
AND A.DBNAME = B.DBNAME
AND A.DBNAME = C.DBNAME
AND B.TYPE <> 'V'
and c.dssize <> 0
order by PERCENTAGE desc,"SPACE GB" DESC ;
