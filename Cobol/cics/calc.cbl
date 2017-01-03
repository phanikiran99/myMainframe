000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. PROGAB54.                                            00020002
000300 DATA DIVISION.                                                   00030000
000400 FILE SECTION.                                                    00040000
000500 WORKING-STORAGE SECTION.                                         00050000
000501 COPY DFHAID.                                                     00050107
000502 COPY DFHBMSCA.                                                   00050207
000510 COPY MAPAB54.                                                    00051003
000520 01 WS-STRING PIC A(75).                                          00052003
000530 01 WS-N1     PIC 99999.                                          00053003
000540 01 WS-N2     PIC 99999.                                          00054003
000550 01 WS-AD     PIC 999999.                                         00055003
000560 01 WS-SU     PIC S9(6).                                          00056003
000570 01 WS-MU     PIC 9(10).                                          00057003
000580 01 WS-DI     PIC 9(10).                                          00058003
000600 01 WS-MESSAGE PIC X(40).                                         00060000
000700 01 WS-LENGTH  PIC S9(4) COMP.                                    00070000
000800 PROCEDURE DIVISION.                                              00080000
000900 A000-MAIN-PARA.                                                  00090000
            IF EIBAID = DFHPF12 THEN                                    00091010
            EXEC CICS                                                   00092010
              RETURN                                                    00093010
            END-EXEC.                                                   00094010
            IF EIBCALEN = 0                                             00095010
001000      MOVE LOW-VALUES TO MAPCALO.                                 00100006
001010      PERFORM SEND-MAP-PARA.                                      00101006
001020      PERFORM RECV-MAP-PARA.                                      00102006
001030      PERFORM COMPUTE-PARA.                                       00103006
001040      PERFORM SEND-MAP-PARA.                                      00104006
001050      PERFORM CLOSE-PARA.                                         00105006
001060 SEND-MAP-PARA.                                                   00106003
                 EXEC CICS SEND MAP('MAPCAL')                           00106112
                           MAPSET('MAPAB54')                            00106212
                           ERASE                                        00106312
                           FREEKB                                       00106412
                 END-EXEC.                                              00106513
001070*     EXEC CICS                                                   00107012
001080*         SEND MAP('MAPCAL') MAPSET('MAPAB54') FROM MAPCALO       00108012
001090*     END-EXEC.                                                   00109012
001100 RECV-MAP-PARA.                                                   00110003
001200      EXEC CICS                                                   00120003
001300       RECEIVE MAP('MAPCAL') MAPSET('MAPAB54') INTO (MAPCALI)     00130005
001400      END-EXEC.                                                   00140003
001500 COMPUTE-PARA.                                                    00150003
001600      MOVE NUMONEI TO WS-N1.                                      00160003
001700      MOVE NUMTWOI TO WS-N2.                                      00170003
001710*     ADDITION                                                    00171003
001800      ADD NUMONEI TO NUMTWOI GIVING WS-AD.                        00180003
001900*     SUBTRACTION                                                 00190003
002000      SUBTRACT NUMTWOI FROM NUMONEI GIVING WS-SU.                 00200003
002100*     MULTIPLY                                                    00210003
002200      MULTIPLY NUMONEI BY NUMTWOI GIVING WS-MU.                   00220003
002300*     DIVISION                                                    00230003
002400      DIVIDE NUMONEI INTO NUMTWOI GIVING WS-DI.                   00240003
002500      MOVE WS-AD TO ADDRESO.                                      00250004
002600      MOVE WS-SU TO SUBRESO.                                      00260004
002700      MOVE WS-MU TO MULRESO.                                      00270004
002800      MOVE WS-DI TO DIVRESO.                                      00280004
002900 CLOSE-PARA.                                                      00290003
003000      EXEC CICS                                                   00300003
003100         RETURN                                                   00310003
003200      END-EXEC.                                                   00320003

