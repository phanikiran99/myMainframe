//* JCL to RUN SQL COMMANDS (DB2I, DB2 INTERACTIVE)             *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *// 
//STEP01 EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSTSPRT DD SYSOUT=*                
//SYSPRINT DD SYSOUT=*                
//SYSUDUMP DD SYSOUT=*                
//SYSOUT DD SYSOUT=*                  
//SYSTSIN DD *                        
DSN SYSTEM(<Db2 subsystem name>)                      
-DISPLAY DATABASE(<DB name>) SPACENAM(*) 
END                                   
//SYSIN DD DUMMY                      