//* JCL TO BE USED FOR BIND(EXAMPLE ONLY)                       *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *//  
//STEP010  EXEC PGM=IKJEFT1B,                         
//         DYNAMNBR=2,                                
//         REGION=0K                       
//**SCEERUN & SDSNLOAD lib Lib differs from system
//*check with sysadmin for details           
//STEPLIB   DD DSN=<SCEERUN library>,DISP=SHR              
//         DD DSN=<&DB2LOAD>,DISP=SHR                   
//          DD DSN=<SDSNLOAD>,DISP=SHR     
//SYSTSPRT DD SYSOUT=*                           
//SYSPRINT DD SYSOUT=*                           
//DBRMLIB  DD DSN=<DBRM Library>,DISP=SHR        
//SYSTSIN  DD *
DSN SYSTEM(<db2 subsystem>)                
    BIND PACKAGE(<schema>) -       
    OWNER(<owner of package>) -              
    QUALIFIER(<qualifier>) -          
    MEMBER(<DBRM name>) -           
    ACTION(REPLACE/ADD) -           
    VALIDATE(BIND) -            
    DEGREE(1)-                  
    ISOLATION(CS) -       <- * Other Isolation are RR,UR           
    EXPLAIN(NO) -         <- * Change to yes for capturing details in plan_table      
    ENABLE(BATCH,CICS,DLIBATCH);  
//                                                    