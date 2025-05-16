       IDENTIFICATION DIVISION.
       PROGRAM-ID. Sample-Invoice.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01  CUSTOMER-NAME            PIC X(30).
       01  CUSTOMER-ENTITY          PIC X(30).
       01  USAGE-KWH                PIC 9(06).
       01  BASE-RATE1               PIC 9(03)V99 VALUE 0.15.
       01  BASE-RATE2               PIC 9(03)V99 VALUE 0.20.
       01  TIER-LIMIT               PIC 9(06) VALUE 500.
       01  AMOUNT-DUE               PIC 9(06)V99 VALUE 0.
       01  TAX-RATE                 PIC 9(02)V99 VALUE 0.08.
       01  ADJUST-RATE              PIC 9(02)V99 VALUE 0.75.
       01  TAX-AMOUNT               PIC 9(06)V99 VALUE 0.
       01  AMOUNT-ADJUSTED          PIC 9(06)V99 VALUE 0.
       01  LOYALTY-DISCOUNT         PIC 9(06)V99 VALUE 0.
       01  DISCOUNT-RATE            PIC 9(02)V99 VALUE 0.
       01  DISCOUNT-DISPLAY         PIC Z(3)9.

       PROCEDURE DIVISION.
           DISPLAY "ENTER CUSTOMER NAME: "
           ACCEPT CUSTOMER-NAME
           DISPLAY "ENTER CUSTOMER ENTITY: "
           ACCEPT CUSTOMER-ENTITY
           DISPLAY "ENTER USAGE IN KWH: "
           ACCEPT USAGE-KWH

           IF USAGE-KWH <= TIER-LIMIT
               COMPUTE AMOUNT-DUE = USAGE-KWH * BASE-RATE1
           ELSE
               COMPUTE AMOUNT-DUE =
                   (TIER-LIMIT * BASE-RATE1) +
                   ((USAGE-KWH - TIER-LIMIT) * BASE-RATE2)
           END-IF

           COMPUTE TAX-AMOUNT = AMOUNT-DUE * TAX-RATE
           COMPUTE AMOUNT-DUE = AMOUNT-DUE + TAX-AMOUNT

           EVALUATE CUSTOMER-ENTITY
               WHEN "A"
                   MOVE 0.15 TO DISCOUNT-RATE
               WHEN "B"
                   MOVE 0.50 TO DISCOUNT-RATE
               WHEN "C"
                   MOVE 0.25 TO DISCOUNT-RATE
               WHEN "D"
                   MOVE 0.15 TO DISCOUNT-RATE
               WHEN "E"
                   MOVE 0.15 TO DISCOUNT-RATE
               WHEN "F"
                   MOVE 0.05 TO DISCOUNT-RATE
               WHEN OTHER
                   MOVE 0 TO DISCOUNT-RATE
           END-EVALUATE

           IF DISCOUNT-RATE > 0
               COMPUTE LOYALTY-DISCOUNT = AMOUNT-DUE * DISCOUNT-RATE
               COMPUTE AMOUNT-ADJUSTED = AMOUNT-DUE - LOYALTY-DISCOUNT
               COMPUTE DISCOUNT-DISPLAY = DISCOUNT-RATE * 100
           ELSE
               MOVE AMOUNT-DUE TO AMOUNT-ADJUSTED
               MOVE 0 TO LOYALTY-DISCOUNT
               MOVE 0 TO DISCOUNT-DISPLAY
           END-IF

           DISPLAY "BILL FOR: " CUSTOMER-NAME
           DISPLAY "COMPANY: " CUSTOMER-ENTITY
           DISPLAY "TOTAL KWH USED: " USAGE-KWH
           DISPLAY "BASE AMOUNT: $" AMOUNT-DUE
           DISPLAY "TAX: $" TAX-AMOUNT
           DISPLAY "TAX RATE: " TAX-RATE
           IF LOYALTY-DISCOUNT > 0
               DISPLAY "LOYALTY DISCOUNT (" DISCOUNT-DISPLAY "%): $"
                   LOYALTY-DISCOUNT
           END-IF
           DISPLAY "TOTAL AMOUNT DUE: $" AMOUNT-ADJUSTED

           STOP RUN.
