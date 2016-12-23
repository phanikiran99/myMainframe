//STEP010  EXEC PGM=ADRDSSU,                                      
//         REGION=32M                                             
//SYSPRINT DD SYSOUT=*                                            
//DATA     DD DSN=<compressed file>,DISP=SHR   <- the same file that is compressed using adrdssu                        
//OUTD1    DD UNIT=3390,VOL=SER=vol1,SPACE=(CYL,(1000,500),RLSE)    < adjust parameters accordingly> 
//SYSIN    DD *                                                   
  RESTORE DS(INC(**)) -                                           
  RENUNC(*.*.**,<HLQ.MLQ.**>) -                     <- Change HLQ and MLQ accordingly                               
  IDD(DATA) ODD(OUTD1) CAT                                        
/*                                                                