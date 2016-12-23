//GETUDATA EXEC PGM=ADRDSSU,REGION=4M              
//*                                                
//SYSPRINT DD SYSOUT=*                             
//ECSOUT    DD DISP=(NEW,CATLG),                   
//            DSN=<New compressed file name>,   <- change accordingly           
//            SPACE=(CYL,(100,50),RLSE),UNIT=SYSDA 
//SYSIN     DD *                                   
   DUMP DS(INC(                   -                
             <file 1>      -                
             <file 2>      -               
             <file ..>      -                
             <file n>      -
                       )) -                                            
          ALLDATA(*)                                   -  
          ODD(ECSOUT) COMPRESS SHARE                      
 /*                                                                      