/*   REXX PROGRAM TO DELETE ALL EMPTY PDS MEMBERS FROM LIST IN  */    
/*   FILE  'USERID().LIST.DATASETS                              */                                            
/*   TO GENERATE ABOVE FILE OPEN FILES IN PATTERN               */                                            
/*   AND THEN DO SAVE LIST                                      */                        
/*   FILE  'USERID().LIST.DATASETS                              */
 TRACE O
 MSETTING = MSG(OFF)
/*   ENABLE TRACE I OR TRACE R , MSG(ON) TO DEBUG               */
 R = ""
 SAY "**************************************************"
 SAY "** TOOL INFO ** DELETE ALL PDS IF THEY ARE EMTPY**"
 SAY "**************************************************"
 SAY "    "
 DSNP = USERID()".LIST.DATASETS"
 
/*   REMOVE SPACES FROM ABOVE LIST FILE                        */ 
/*   ENABLE BELOW LINES OF CODE INCASE IF YOU WANT TO ACCEPT   */ 
/*   THE FILE BY ENTERING INPUT                                */ 
/*   SAY 'ENTER LIST FILES'                                    */ 
/*   PARSE UPPER DSNP                                          */

 DSNP = STRIP(DSNP)
   ADDRESS TSO "ALLOC DA('"DSNP"') DD(LISFIL) SHR LRECL(140),
                RECFM(F B) BLKSIZE(6160) SPACE(10 10) TRACK UNIT(3390),
                CATALOG"
/*   SAY 'RC DURING ALLOCATION' RC*/
/*   INCASE ALLOCATION OF FILE ALLOCATION FAILED THEN           */
/*   FREE THE FILESPACE AND THEN RETRY THE COMMAND              */
   IF RC >= 12 THEN
   DO
     "FREE FI(LISFIL)"
    SAY 'SOME PROBLEM DURING ALLOCATION - RETRY PLS'
    EXIT 12
   END
/*   NORMAL PROCESSING          */
   ELSE
   ADDRESS TSO "EXECIO * DISKR LISFIL (STEM LISFIL. FINIS"
   SAY 'RC FOR READ' RC
 LEN = RIGHT(LISFIL.0,6)
/* SAY LEN*/
 DO LINE = 1 TO LEN
     CURPDS = STRIP(SUBSTR(LISFIL.LINE,1,45))
     SAY CURPDS
     DUMMY = OUTTRAP("MEMB.","*")                                       
     ADDRESS TSO                                                        
     "LISTDS '"CURPDS"' MEMBERS"                                        
     DUMMY = OUTTRAP("OFF")                                             
     SAY MEMB.0
     IF MEMB.0 = 6 THEN
     DO
      ADDRESS TSO "DELETE" "'"CURPDS"'"
     END
     ELSE DO
      SAY 'MEMBERS EXIST IN' CURPDS
     END
 END
 "FREE FI(LISFIL)"
 EXIT                                                                   

