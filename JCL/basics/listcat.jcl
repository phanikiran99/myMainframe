//* List cat to find out all details about a file
//STEP010 EXEC PGM=IDCAMS                     
//SYSPRINT DD SYSOUT=*                        
//SYSIN    DD *                               
 LISTCAT ENTRIES('filename') VOLUME/ALL/ALLOCATION
/*                                            