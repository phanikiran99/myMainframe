      *SAMPLE PROGRAM TO READ FILE AND DISPLAY IN SPOOL                 00010004
       IDENTIFICATION DIVISION.                                         00020000
       PROGRAM-ID. READPS.                                              00030005
      *ENVIRONMENTAL STARTS HERE                                        00040004
       ENVIRONMENT DIVISION.                                            00050000
          INPUT-OUTPUT SECTION.                                         00060000
          FILE-CONTROL.                                                 00070000
           SELECT SAMPLE ASSIGN TO FILEDD1                              00080006
           ORGANIZATION IS SEQUENTIAL                                   00090023
           FILE STATUS WS-IN1.                                          00100014
      *DATA DIVISION STARTS HERE                                        00110004
       DATA DIVISION.                                                   00120000
          FILE SECTION.                                                 00130000
      *FILE DEFINITION                                                  00140004
          FD SAMPLE.                                                    00150004
          01 SAMPLE-FILE.                                               00160009
             05 SAMPLE-DATA1 PIC A(20).                                 00170010
             05 SAMPLE-DATA2 PIC A(30).                                 00180010
             05 FILLER PIC X(30).                                       00181024
          WORKING-STORAGE SECTION.                                      00190000
      *WORKING STORAGE VARIABLE FOR FILES                               00200004
          77 WS-IN1 PIC X(2).                                           00201016
          01 WS-FILE.                                                   00210009
             05 WS-DATA1 PIC A(20).                                     00220010
             05 WS-DATA2 PIC A(30).                                     00230010
             05 FILLER PIC X(30).                                       00231024
          01 WS-EOF PIC X(01) VALUE 'N'.                                00240013
             88 WS-EOF-N VALUE 'N'.                                     00250013
             88 WS-EOF-Y VALUE 'Y'.                                     00260017
      *ACTUAL PROCESS STARTS HERE.                                      00270004
       PROCEDURE DIVISION.                                              00280000
           DISPLAY 'PROGRAM STARTED'                                    00281021
           PERFORM 000-OPEN-PARA.                                       00290012
           PERFORM 001-READ-PARA  UNTIL WS-EOF-Y.                       00300012
           PERFORM 003-CLOSE-PARA.                                      00320012
           STOP RUN.                                                    00330012
       000-OPEN-PARA.                                                   00340012
           DISPLAY 'IN OPEN PARA'                                       00341022
           OPEN INPUT SAMPLE.                                           00350012
           DISPLAY WS-IN1 'FILE STATUS'.                                00360022
           IF WS-IN1 NOT = '00'                                         00370012
             SET WS-EOF-Y TO TRUE                                       00380012
           END-IF.                                                      00390012
       001-READ-PARA.                                                   00400012
           DISPLAY 'IN READ PARA'                                       00401025
           READ SAMPLE                                                  00410019
             AT END                                                     00420020
                MOVE 'Y' TO WS-EOF                                      00430020
             NOT AT END                                                 00440020
                MOVE SAMPLE-FILE TO WS-FILE.                            00441026
                PERFORM 002-ACTION-PARA.                                00450020
       002-ACTION-PARA.                                                 00470012
           DISPLAY 'IN ACTION PARA'                                     00471025
           DISPLAY WS-FILE.                                             00480018
       003-CLOSE-PARA.                                                  00490012
           CLOSE SAMPLE.                                                00500018
