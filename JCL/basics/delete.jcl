//* Delete gdg,vsam files                                       *//
//* Modified: 26-12-2016 By : Phani                             *//
//*                                                             *// 
//STEP1  EXEC PGM=IDCAMS                              
//SYSPRINT DD SYSOUT=*                                
//SYSIN DD *                                          
  DELETE (<file name>)GDG  FORCE                 
/*                                                    