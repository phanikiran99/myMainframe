      *PROGRAM TO TEST DB2 CURSORS                                      00010000
      *USED CENSUS DATA AS SAMPLE                                       00020000
      *JUST SELECTS THE DATA                                            00030000
      *AND DISPLAYS IN SPOOL                                            00040000
       IDENTIFICATION DIVISION.                                         00060000
       PROGRAM-ID. DB2CURS.                                             00070000
       ENVIRONMENT DIVISION.                                            00080000
       DATA DIVISION.                                                   00090000
       WORKING-STORAGE SECTION.                                         00100000
           EXEC SQL                                                     00110000
           INCLUDE SQLCA                                                00120000
              END-EXEC.                                                 00130000
           EXEC SQL                                                     00131000
            DECLARE CURS_CE CURSOR FOR                                  00132000
             SELECT STATE_UT,POPULATION                                 00133000
             FROM   CENSUS                                              00135000
           END-EXEC.                                                    00136000
       01 NIND PIC S9(4) COMP.                                          00140000
       01  DCLCENSUS.                                                   00180000
           10 STATE-UT             PIC X(30).                           00190000
           10 POPULATION           PIC S9(9) USAGE COMP.                00200000
           10 GROWTH-PER           PIC S9(9) USAGE COMP.                00210000
           10 RURAL-POP            PIC S9(9) USAGE COMP.                00220000
           10 URBAN-POP            PIC S9(9) USAGE COMP.                00230000
           10 YEAR-OF-SUR          PIC S9(9) USAGE COMP.                00240000
           10 RATIO                PIC S9(9) USAGE COMP.                00250000
       PROCEDURE DIVISION.                                              00260000
       MAIN-PARA.                                                       00270000
      * SELECT ALL RECORDS USING CURSOR AND DISPLAY REPORT IN SPOOL     00280000
           EXEC SQL                                                     00290000
               OPEN CURS_CE                                             00300000
           END-EXEC.                                                    00301000
           PERFORM 000-FETCH-PARA UNTIL SQLCODE = 100.                  00302000
      * FETCH THE RECORDS                                               00302100
       000-FETCH-PARA.                                                  00303000
                  EXEC SQL                                              00304000
                     FETCH CURS_CE INTO :STATE-UT,:POPULATION           00305100
                  END-EXEC.                                             00308000
                  DISPLAY 'STATE ', STATE-UT , ' HAS ', POPULATION.     00309003
       001-CLOSE-PARA.                                                  00310000
                  EXEC SQL                                              00320000
                    CLOSE CURS_CE                                       00330000
                  END-EXEC.                                             00340000
               STOP RUN.                                                00910000

