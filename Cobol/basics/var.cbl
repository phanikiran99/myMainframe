IDENTIFICATION DIVISION.
PROGRAM-ID. VAR-COB1.
DATA DIVISION.
 WORKING-STORAGE SECTION.
   01 WS-BASIC-VAR.
     05 WS-INT  PIC 9(3) VALUE 01.
     05 WS-CHAR PIC A(2) VALUE 'AB'.
     05 WS-ALPH PIC X(2) VALUE 'z1'.
     05 WS-DEC  PIC 9V99 VALUE 2.14.
     05 WS-SIGN PIC S9(2) VALUE -24.
     05 WS-ADEC PIC PPP999.
     05 WS-DATE PIC X(6). 
    01 WS-ADDRESS.
     05 WS-NAME PIC X(20).
     05 WS-PIN  PIC 9(5).
    01 WS-ADDRESS-NEW REDEFINES WS-ADDRESS PIC X(20).
    01 WS-NUM1 PIC 9(2) USAGE IS COMP VALUE 24.
    01 WS-NUM2 USAGE IS COMP-1  VALUE 24.
    01 WS-NUM3 USAGE IS COMP-2 VALUE 24.
    01 WS-NUM4 PIC 9(2) USAGE IS COMP-3 VALUE 24.
    01 WS-TABLE.
      05 WS-A OCCURS 3 TIMES INDEXED BY I.
         10 WS-B PIC A(2).
         10 WS-C OCCURS 2 TIMES INDEXED BY J.
            15 WS-D PIC X(3).
    COPY abc.
    01 WS-MARK.
      88 PASS VALUES ARE 041 THRU 100.
      88 FAIL VALUES ARE 000 THRU 40.
PROCEDURE DIVISION.
    PERFORM A-PARA.
    A-PARA.
    DISPLAY '* DIFFERENT VARIABLE TYPES IN COBOL *'.
    DISPLAY 'INTEGER: ',WS-INT.
    DISPLAY 'CHAR: ', WS-CHAR.
    DISPLAY 'ALPHA :', WS-ALPH.
    DISPLAY 'DECIMAL :', WS-DEC.
    DISPLAY 'SIGNED : ', WS-SIGN.
    MOVE WS-INT TO WS-ADEC.
    DISPLAY 'ASSUMED DECIMAL: ', WS-ADEC. 
    ACCEPT WS-DATE FROM DATE.
    DISPLAY 'DATE: ', WS-DATE.
    DISPLAY '* INITIALIZATION *'
    DISPLAY 'BEFORE INIT: ', WS-ADDRESS.
    INITIALIZE WS-NAME REPLACING NUMERIC DATA BY 00 ALPHANUMERIC DATA BY 'UNKNOWN'.
    DISPLAY 'AFTER-INIT :', WS-ADDRESS.
    PERFORM B-PARA THROUGH F-PARA.
    
    B-PARA.
    DISPLAY '* COMPUTE *'
    COMPUTE WS-PIN = WS-INT * 2 .
    DISPLAY WS-PIN.
    
    C-PARA.
    DISPLAY '* REDEFINES *'
    DISPLAY 'STORAGE USED FOR NEW:', WS-ADDRESS-NEW.
    MOVE '00' TO WS-ADDRESS-NEW.
    DISPLAY 'AFTER CHANGING ORIGINAL:', WS-ADDRESS.
    DISPLAY 'AFTER CHANGING REDEFINED:', WS-ADDRESS-NEW.
    
    D-PARA.
    DISPLAY '* COMP *'
    DISPLAY 'COMP,COMP-1,COMP-2,COMP-3', WS-NUM1,WS-NUM2,WS-NUM3,WS-NUM4.
    
    E-PARA.
    DISPLAY '* COPY BOOKS *'
    DISPLAY WS-COPY.
    
    F-PARA.
    DISPLAY '* IF *'
    IF WS-INT IS POSITIVE THEN
      DISPLAY 'IT IS POSITIVE'
    ELSE
      IF WS-INT IS LESS THAN OR EQUAL TO 0 THEN
        DISPLAY 'IT IS NEGATIVE'    
      ELSE
        DISPLAY 'IT IS ZERO'
      END-IF.
    DISPLAY 'CONDITIONAL LEVEL 88/EVALUATE'.
    MOVE 085 TO WS-MARK.
    DISPLAY WS-MARK.
    IF PASS
         DISPLAY 'PASSED'.
    IF FAIL
         DISPLAY 'FAILED'.
    PERFORM G-PARA THROUGH Z-PARA.
         
    G-PARA.
    DISPLAY 'STRING OPERATIONS'.
    MOVE 'PHANIKIRAN' TO WS-NAME.
    MOVE 00 TO WS-INT.
    DISPLAY ' COUNT NO OF CHARECTERS'.
    INSPECT WS-NAME TALLYING WS-INT FOR ALL CHARACTERS.
    DISPLAY 'NO OF CHAR: ', WS-INT. 
    MOVE 00 TO WS-INT.
    INSPECT WS-NAME TALLYING WS-INT FOR ALL 'AN'
    DISPLAY 'NO OF AN: ', WS-INT.
    DISPLAY 'REPLACE SPECIFIC CHARS'
    INSPECT WS-NAME REPLACING ALL 'AN' BY 'an'.
    DISPLAY WS-NAME.
    DISPLAY '*STRING*'.
    MOVE 0 TO WS-INT .
    STRING WS-NAME DELIMITED BY SPACE
           WS-NAME DELIMITED BY SIZE
           INTO WS-NAME
           WITH POINTER WS-INT
           ON OVERFLOW DISPLAY 'OVERFLOW'
           NOT ON OVERFLOW DISPLAY 'NOT OVERFLOW'
    END-STRING.
    DISPLAY WS-NAME,WS-INT.
    DISPLAY '* UNSTRING *' 
    MOVE 0 TO WS-INT.
    UNSTRING WS-NAME DELIMITED BY 'a'
             INTO WS-FIRSTNAME,WS-NAME 
             WITH POINTER WS-INT
             ON OVERFLOW DISPLAY 'OVERFLOW'
             NOT ON OVERFLOW DISPLAY 'NOT OVERFLOW'
    END-UNSTRING.
    DISPLAY WS-FIRSTNAME, ' ', WS-NAME.
    DISPLAY WS-INT.
    
    H-PARA.
    DISPLAY '* TABLE/ARRAYS *'.
    MOVE '12ABCDEF34GHIJKL56MNOPQR' TO WS-TABLE.
    DISPLAY WS-TABLE.
    DISPLAY 'WS-TABLE  : ' WS-TABLE.
    DISPLAY 'WS-A(1)   : ' WS-A(1).
    DISPLAY 'WS-B(1)   : ' WS-B(1).
    DISPLAY 'WS-C(1,1) : ' WS-C(1,1).
    DISPLAY 'WS-C(1,2) : ' WS-C(1,2).
    DISPLAY 'WS-A(2)   : ' WS-A(2).
    DISPLAY 'WS-B(2)   : ' WS-B(2).
    DISPLAY 'WS-C(2,1) : ' WS-C(2,1).
    DISPLAY 'WS-C(2,2) : ' WS-C(2,2).
    DISPLAY 'WS-A(3)   : ' WS-A(3).
    DISPLAY 'WS-C(3,1) : ' WS-C(3,1).
    DISPLAY 'WS-C(3,2) : ' WS-C(3,2).
    DISPLAY ' * ACCESS BY INDEX * ' 
    SET I J TO 1.
    DISPLAY WS-C(I,J).
    SET I J UP BY 1.
    DISPLAY WS-C(I,J).
    DISPLAY '* SEARCH/SEACHALL *'
    SEARCH WS-A
        AT END DISPLAY 'NOT FOUND'
        WHEN WS-A(I) = 'A'
            DISPLAY 'LETTER FOUND'
    END-SEARCH.    
    Z-PARA.
    STOP RUN.

	
