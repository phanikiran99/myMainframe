//BIND     EXEC PGM=IKJEFT01,DYNAMNBR=20                       
//STEPLIB  DD   DSN=DSN810.SDSNLOAD,DISP=SHR                   
//SYSTSPRT DD   SYSOUT=*                                       
//SYSPRINT DD   SYSOUT=*                                       
//SYSUDUMP DD   SYSOUT=*                                       
//SYSTSIN  DD  *                                               
       DSN SYSTEM(DB2P)                                        
       BIND PLAN(DB2OPER) MEM(DB2OPER) ACT(REP) ISOLATION(CS) -
       EXPLAIN (NO) -                                          
       LIB('TRNG497.COBOL.DBRM')-                              
       OWNER(TRNGGRP)                                          
       END                                                     
/*                                                             
//                                                             
