//* JCL to RENAME ANY FILE, VSAM,PS,PDS ETC                     *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *// 
//STEP010  EXEC PGM=IDCAMS,COND=(0,NE)            
//SYSPRINT DD    SYSOUT=*                         
//SYSIN    DD  *                                  
 ALTER <old file name>           -  
  NEWNAME(<new file name>)             
/*                                                