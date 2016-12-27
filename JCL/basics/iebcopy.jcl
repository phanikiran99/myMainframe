//* JCL EXAMPLE IEBCOPY,PDS MEMBER TO PDS MEMBER(SELECTED)      *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *// 
//IEBCOP1  EXEC IEBCOPY                     
//DDIN    DD DSN=<input lib name>,DISP=SHR
//DDOUT   DD DSN=<output lib name>,DISP=SHR           
//SYSPRINT DD SYSOUT=*                      
//SYSOUT   DD SYSOUT=*                      
//SYSIN    DD                               
  COPY INDDN=DDIN,OUTDDN=DDOUT            
  SELECT MEMBER=<MEMBER NAME>                     
/*                                          
//                                          