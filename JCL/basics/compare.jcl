//**********************************************************************
//*                COMPARE TWO PDS AND DISPLAY IN SPOOL                 
//**********************************************************************
//SUPERC EXEC PGM=ISRSUPC,                                              
//       PARM=(DELTAL,LINECMP,'','')                                    
//OLDDD  DD DSN=<old lib name>,DISP=SHR                                
//NEWDD  DD DSN=<new lib name>,DISP=SHR                               
//OUTDD  DD SYSOUT=A                                                    
//SYSPRINT DD SYSOUT=*                                                  
//SYSDUMP DD SYSOUT=*                                                   
/*                                                                      