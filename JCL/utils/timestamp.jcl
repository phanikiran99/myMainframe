//*  CREATES MODULE TIMESTAMP LIST FROM AMBLIST OUTPUT          *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *//                                               
//*-------------------------------------------------------------------*
//*  RUN AMBLIST                                                       
//*-------------------------------------------------------------------*
//LIST1   EXEC PGM=AMBLIST                                             
//SYSPRINT DD DSN=&&AMBLIST,DISP=(,PASS),UNIT=SYSDA,                   
//         SPACE=(CYL,(4,4),RLSE),DCB=(RECFM=FBA,LRECL=121)            
//SYSLIB   DD DSN=<Load Lib name>,DISP=SHR  <-SPECIFY LOAD MODULE LIB
//SYSIN    DD *                                                        
 LISTIDR                                                               
/*                                                                     
//*-------------------------------------------------------------------*
//*  SELECT MODULE NAME AND TIMESTAMP                                  
//*-------------------------------------------------------------------*
//SELECT  EXEC PGM=SORT                                                
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=&&AMBLIST,DISP=(OLD,DELETE)                         
//MODNAM   DD  DSN=&&MODNAM,DISP=(,PASS),UNIT=SYSDA,                   
//             SPACE=(CYL,(1,1),RLSE),DCB=(RECFM=FB,LRECL=80)          
//MODTIM   DD  DSN=&&MODTIM,DISP=(,PASS),UNIT=SYSDA,                   
//             SPACE=(CYL,(1,1),RLSE),DCB=(RECFM=FB,LRECL=80)          
//SYSIN    DD *                                                        
    OPTION COPY                                                        
    OUTFIL FNAMES=MODNAM,                                              
      INCLUDE=(6,12,CH,EQ,C'MEMBER NAME:'),                            
      OUTREC=(20,8,64X,SEQNUM,8,ZD)                                    
    OUTFIL FNAMES=MODTIM,                                              
      INCLUDE=(11,31,CH,EQ,C'THIS LOAD MODULE WAS PRODUCED BY'),       
      OUTREC=(104,4,C'/',92,3,1X,112,8,55X,SEQNUM,8,ZD)                
/*                                                                     
//*-------------------------------------------------------------------*
//*  JOINING MODULE NAMES AND TIMESTAMPS                               
//*-------------------------------------------------------------------*
//JOIN    EXEC PGM=ICETOOL                                             
//TOOLMSG  DD  SYSOUT=*                                                
//DFSMSG   DD  SYSOUT=*                                                
//TOOLIN   DD  *                                                       
* REFORMAT MODNAM TO T1 SO IT CAN BE SPLICED                           
  COPY FROM(MODNAM) TO(T1) USING(CTL1)                                 
* REFORMAT MODTIM TO T1 SO IT CAN BE SPLICED                           
  COPY FROM(MODTIM) TO(T1) USING(CTL2)                                 
* SPLICE RECORDS IN T1 WITH MATCHING ON FIELDS                         
  SPLICE FROM(T1) -                                                    
    ON(73,8,CH)   - SEQNUM                                             
    WITH(11,8)    - BUILD DATE                                         
    WITH(21,8)    - BUILD TIMESTAMP                                    
    TO(OUT)                                                            
/*                                                                     
//MODNAM   DD  DSN=&&MODNAM,DISP=(OLD,DELETE)                        
//MODTIM   DD  DSN=&&MODTIM,DISP=(OLD,DELETE)                        
//T1       DD  DSN=&&T1,UNIT=SYSDA,SPACE=(CYL,(1,1)),DISP=(MOD,PASS) 
//OUT      DD  DSN=&SYSUID..DS.LIST,DISP=(,CATLG),UNIT=SYSDA,        
//         SPACE=(CYL,(4,4),RLSE)                                    
//CTL1CNTL DD  *                                                     
* MOVE MODNAM FIELDS TO THEIR LOCATIONS FOR THE OUTPUT DATA SET      
  OUTREC FIELDS=(1:1,8,   MODULE NAME                                
                 73:73,8) SEQUENCE NUMBER                            
/*                                                                   
//CTL2CNTL DD  *                                                     
* MOVE MODTIM FIELDS TO THEIR LOCATIONS FOR THE OUTPUT DATA SET      
  OUTREC FIELDS=(11:1,8,  BUILD DATE                                 
                 21:10,8, BUILD TIMESTAMP                            
                 73:73,8) SEQUENCE NUMBER                            
/*                                                                   