       IDENTIFICATION DIVISION.                           
       PROGRAM-ID. SPECIAL.                               
       ENVIRONMENT DIVISION.                               
       CONFIGURATION SECTION.                             
       SOURCE-COMPUTER. IBM-370.                           
       SPECIAL-NAMES.                                     
           CLASS WS-VALID-ALPHA IS                         
				  '0' THRU '9'
				  'A' THRU 'J'
				  'J' THRU 'R'
				  'S' THRU 'Z'
                  '@' '#' '*'                               
       DATA DIVISION.                                     
       WORKING-STORAGE SECTION.                           
       01  WS-INP        PIC X(8).                       
       PROCEDURE DIVISION.                                 
           MOVE 'ABJKST01' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'CDLMUV23' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'EFNOWX45' TO WS-INP                     
           MOVE 'GHPQYZ67' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'IJRSAB89' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'KLTUCD@#' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'MNVWEF#*' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE '@#*@#*@#' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'IM SPACE' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           MOVE 'PERCENT%' TO WS-INP                     
           PERFORM VALIDATE-CUSIP                         
           GOBACK.                                         
       VALIDATE-CUSIP.                                     
           IF WS-INP IS NOT WS-VALID-ALPHA
           THEN                                           
              DISPLAY 'WS-INP >' WS-INP '< IS NOT VALID.'
           ELSE                                           
              DISPLAY 'WS-INP >' WS-INP '< IS VALID.'   
           END-IF.
