      *PROGRAM TO TEST DB2 OPERATIONS                                   00010004
      *USED CENSUS DATA AS SAMPLE                                       00020004
      *TESTS THREE BASIC FUNCTIONS                                      00030004
      *SELECT UPDATE DELETE                                             00040004
      *ALSO HANDLES ERRORS                                              00050004
       IDENTIFICATION DIVISION.                                         00060000
       PROGRAM-ID. DB2OPER.                                             00070000
       ENVIRONMENT DIVISION.                                            00080000
       DATA DIVISION.                                                   00090000
       WORKING-STORAGE SECTION.                                         00100000
           EXEC SQL                                                     00110000
           INCLUDE SQLCA                                                00120000
              END-EXEC.                                                 00130000
       01 NIND PIC S9(4) COMP.                                          00131028
      *01 EMP-REC.                                                      00140004
      *  05 EMPNO     PIC  9(4).                                        00150004
      *  05 EMPNAME   PIC  X(30).                                       00160004
       01  DCLCENSUS.                                                   00170004
           10 STATE-UT             PIC X(30).                           00180004
           10 POPULATION           PIC S9(9) USAGE COMP.                00190004
           10 GROWTH-PER           PIC S9(9) USAGE COMP.                00200004
           10 RURAL-POP            PIC S9(9) USAGE COMP.                00210004
           10 URBAN-POP            PIC S9(9) USAGE COMP.                00220004
           10 YEAR-OF-SUR          PIC S9(9) USAGE COMP.                00230004
           10 RATIO                PIC S9(9) USAGE COMP.                00240004
       PROCEDURE DIVISION.                                              00250000
       MAIN-PARA.                                                       00260000
      * SELECT FIRST ROW BY POPULATION AND DISPLAY ITS VALUE IN SPOOL   00270004
           EXEC SQL                                                     00280000
               SELECT STATE_UT                                          00290004
               INTO  :STATE-UT                                          00300005
                FROM CENSUS                                             00310004
               ORDER BY POPULATION DESC                                 00320004
               FETCH FIRST ROW ONLY                                     00330002
           END-EXEC.                                                    00340000
           IF SQLCODE = 0                                               00341013
               DISPLAY 'MOST POP STATE IS:' STATE-UT                    00343015
           ELSE                                                         00344013
               DISPLAY 'ERROR/SELECT'                                   00345022
               DISPLAY 'SQL CODE:'       SQLCODE                        00350016
           END-IF.                                                      00360013
      * INSERT NEW RECORDS                                              00370007
              MOVE 'WEST BENGAL' TO STATE-UT.                           00371021
              MOVE 091347736     TO POPULATION.                         00372021
              MOVE 13            TO GROWTH-PER.                         00373021
              MOVE 062213676     TO RURAL-POP.                          00374021
              MOVE 2913460       TO URBAN-POP.                          00375021
              MOVE 2011          TO YEAR-OF-SUR.                        00376021
              MOVE 947           TO RATIO.                              00377021
           EXEC SQL                                                     00380007
               INSERT INTO CENSUS                                       00390010
               VALUES(:STATE-UT,:POPULATION,:GROWTH-PER,:RURAL-POP,     00400019
                      :URBAN-POP,:YEAR-OF-SUR,:RATIO)                   00410019
           END-EXEC.                                                    00420007
           IF SQLCODE = 0                                               00421018
               DISPLAY 'RECORD INSERTED'                                00422015
           ELSE                                                         00423013
               DISPLAY 'ERROR/INSERT'                                   00424016
               DISPLAY 'SQL CODE:'       SQLCODE                        00430016
               DISPLAY 'SQL STATE:' SQLSTATE                            00440016
           END-IF.                                                      00450013
      * UPDATE EXISTING RECORDS                                         00460011
           MOVE 2016 TO YEAR-OF-SUR.                                    00461023
           EXEC SQL                                                     00470011
               UPDATE CENSUS                                            00480011
               SET YEAR_OF_SUR  = :YEAR-OF-SUR                          00490026
               WHERE YEAR_OF_SUR = 2011                                 00491027
           END-EXEC.                                                    00500011
           IF SQLCODE = 0                                               00501018
               DISPLAY 'RECORDS UPDATED'                                00502015
           ELSE                                                         00503013
               DISPLAY 'ERROR/UPDATE'                                   00504022
               DISPLAY 'SQL CODE:'       SQLCODE                        00510016
               DISPLAY 'SQLSTATE:' SQLSTATE                             00511022
           END-IF.                                                      00520013
      * TRY TO MOVE NULL TO NOT NULL VALUE OF STATE                     00521028
           MOVE -1   TO NIND.                                           00522028
           MOVE LOW-VALUES TO STATE-UT.                                 00522131
           EXEC SQL                                                     00523030
               UPDATE CENSUS                                            00524028
               SET STATE_UT = :STATE-UT:NIND                            00525031
               WHERE YEAR_OF_SUR = 2016                                 00526028
           END-EXEC.                                                    00527028
           IF SQLCODE = 0                                               00528028
               DISPLAY 'RECORDS UPDATED'                                00529028
           ELSE                                                         00529128
               DISPLAY 'ERROR/UPDATE/NIND'                              00529228
               DISPLAY 'SQL CODE:'       SQLCODE                        00529328
               DISPLAY 'SQLSTATE:' SQLSTATE                             00529428
           END-IF.                                                      00529528
               STOP RUN.                                                00530011

