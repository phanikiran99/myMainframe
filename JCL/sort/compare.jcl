//STEP0001 EXEC PGM=SORT                                         
//SYSOUT   DD SYSOUT=*                                           
//IN1      DD DISP=SHR,DSN=<INPUT1 File1>                         
//IN2      DD DISP=SHR,DSN=<INPUT2 File2>                        
//MATCHED  DD DISP=OLD,DSN=<MATCHED RECORD OUTPUT>                       
//UNMATCH  DD DISP=OLD,DSN=<UNMATCH RECORD OUTPUT>
//* Documentation: 
//* Change Joinkeys to have the selected fields from files
//* Reformat the data available 
//* More documentation : http://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/
//* com.ibm.zos.v2r1.icea100/ice2ca_Example_5_-_Paired_and_unpaired_F1_F2_records__indicator_method_.htm                    
//SYSIN    DD *                                                   
  OPTION COPY                                                     
  JOINKEYS F1=INA,FIELDS=(1,300,A)                          
  JOINKEYS F2=INB,FIELDS=(1,300,A)                               
  JOIN UNPAIRED                                                   
  REFORMAT FIELDS=(F1:1,300,F2:1,300,?)                           
  INREC IFTHEN=(WHEN=(601,1,CH,EQ,C'2'),OVERLAY=(1:301,300))     
  OUTFIL FNAMES=MATCHED,INCLUDE=(601,1,CH,EQ,C'B'),BUILD=(1,300) 
  OUTFIL FNAMES=UNMATCH,INCLUDE=(601,1,SS,EQ,C'1,2'),BUILD=(1,300)
/*