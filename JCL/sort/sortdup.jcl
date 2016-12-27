//* JCL to Sort and eliminate/include only duplicates  ICETOOL  *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *// 
//STEP010 EXEC PGM=ICETOOL                       
//TOOLMSG DD SYSOUT=*                            
//DFSMSG DD  SYSOUT=*                            
//INP  DD DSN=IN14267.TEST.INPUT,DISP=SHR        
//BCKP DD DSN=IN14267.TEST.OUTPUT,DISP=OLD       
//TOOLIN DD *                                    
 SELECT FROM(INP) TO(BCKP) ON(1,10,CH) FIRSTDUP  
/* 
//
//*OTHER POSSIBLE COMBINATIONS
//*FIRST - keep only the first record for each value (that is, records with non-duplicate values, and the first record for duplicate values)
//*FIRST(n) - keep only the first n records for each value (that is, records with non-duplicate values, and the first n records for duplicate values)
//*LAST - keep only the last record for each value (that is, records with non-duplicate values, and the last record for duplicate values)
//*FIRSTDUP - only keep the first record for duplicate values
//*FIRSTDUP(n) - only keep the first n records for duplicate values
//*LASTDUP - only keep the last record for duplicate values
//*ALLDUPS - only keep records with duplicate values
//*NODUPS - only keep records with non-duplicate values
//*EQUAL(n) - only keep records with values that occur n times
//*HIGHER(n) - only keep records with values that occur more than n times
//*LOWER(n) - only keep records with values that occur less than n times
