//* JCL List cat to find out all details about a file           *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *// 
//STEP010 EXEC PGM=IDCAMS                     
//SYSPRINT DD SYSOUT=*                        
//SYSIN    DD *                               
 LISTCAT ENTRIES('filename') VOLUME/ALL/ALLOCATION
/*                                            