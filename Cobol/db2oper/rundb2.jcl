//JS0010   EXEC PGM=IKJEFT01,DYNAMNBR=20 COND=(4,LT)         
//STEPLIB  DD DSN=DSN810.SDSNLOAD,DISP=SHR                   
//SYSTSPRT DD SYSOUT=*                                       
//SYSPRINT DD SYSOUT=*                                       
//SYSUDUMP DD SYSOUT=*                                       
//SYSOUT   DD SYSOUT=*                                       
//SYSTSIN DD *                                               
 DSN SYSTEM(DB2P)                                            
 RUN PROGRAM(DB2OPER) PLAN(DB2OPER) LIB('TRNG497.COBOL.LOAD')
 END                                                         
//*                                                          
