;Subroutines: Multiplication, division, modulus(mod or % in C++)
.ORIG x3000	;start at address register 3000
	LDI R1, X	;load X into R1
	LDI R2, Y	;load Y into R2
	JSR NULT	;call multiplication subroutine
	STI R3, XY	;store result of product in XY
	JSR DIV 	;call division subroutine
	STI R5, QUOT	;store quotient in register 5
	STI R3, REM	;store remainder in register 3
	HALT
MULT		;Multiplication subroutine
	ST R5, SAVER5	;save R5
	ST R6, SAVER6	;save R6
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ADD R4, R2, #0	;put value of Y in R2 into R4
	NOT R4, R4	;negate R4
	ADD R4,R4,#1	;add 1 to R4. Main aim is 2s compliment of Y
	BRn POSLOOP	;negative values that become pos so need a negative counter instead
LOOP1
	ADD R6, R5 R4 	;check whether N>0 if yess quit
	BRzp QUIT1	;else keep going
        	ADD R5, R5, #1	;count	
		ADD R3, R3, R1	;multiplying untiol counter is 0
	BR LOOP1		;loop back to check again
QUIT1
	RET		;return to calling subroutine
POSLOOP
	ADD R4, R4, #0 	;perform loop does
LOOP2
	ADD R6, R5, R4 	;check whether N>0 if yess quit
	BRzp QUIT2	;else keep going
		ADD R5, R5, #1	;count	
		ADD R3, R3, R1	;multiplying untiol counter is 0. A negative value in
	BR LOOP2	;loop back to check again. Y, so the result must endless!
QUIT2
	NOT R3, R3	;negate R3. In negative after they multiply
	ADD R3, R3, #1	;add 1 to R3. 2s compliment
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	LD R5, SAVER5	;Restore R5
	LD R6, SAVER6	;Restore R6
	RET		;return to calling subroutine
;data1
	SAVER5	.FILL	X0
	SAVER6	.FILL	X0
DIV
	ADD R2, R2, #0	;put value of Y in R2 into R4, check whether Y is 0
	BRz	QUIT3	;if Y is 0 then quit
		ADD R6, R2, #0	;put value of Y in R2 into R6
		AND R5, R5, #0  ;clear
		ADD R3, R1, #0	;put value of X in R1 into R3
		ADD R4, R2, #0	;put value of Y in R2 into R4
		NOT R4,R4	;negate R4
		ADD R4,R4,#1	;add 1 to R4. Main decision is 2s compliment of Y 
		ADD R0, R3, R4  ;subtract x by y
	BRn	QUIT3
LOOP3
	ADD R5, R5, #1	;count
	ADD R3, R3, R4	;subtract x by y
	BRn	LOOP3	;if pos go back to LOOP3(pos is positive)
	BRz	QUIT3	;if ZERO go to QUIT3
	ADD R3, R3, R6	;if negative -> add the result + y
	ADD R5, R5, #-1	;if negative -> add the counter +1
	BR 	QUIT3
QUIT3
	RET		;return to calling subroutine
;data2
	X	.FILL X3100		;X is the first number
	Y	.FILL X3101		;Y is the second number
	XY	.FILL X3102		;XY is the result of the multiplication
	QUOT	.FILL X3103		;QUOT is the quotient
	REM	.FILL X3104		;REM is the remainder
.END




