;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : os.asm                                 ;
;  author      : 
;  description : LC4 Assembly program to serve as an OS ;
;                TRAPS will be implemented in this file ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;

;; TO-DO:
;; 1) Open up your last codio assignment (in a separate browswer window)
;; 2) In that window, open up your working os.asm file:
;;    -select everything in the file, and "copy" this content (Conrol-C) 
;; 3) Return to the current codio assignment, paste the content into this os.asm 
;;    -now you can use the os.asm from your last HW in this HW
;; 4) Save the updated os.asm file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;   OS - TRAP VECTOR TABLE   ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.OS
.CODE
.ADDR x8000
  ; TRAP vector table
  JMP TRAP_GETC           ; x00
  JMP TRAP_PUTC           ; x01
  JMP TRAP_GETS           ; x02
  JMP TRAP_PUTS           ; x03
  JMP TRAP_TIMER          ; x04
  JMP TRAP_GETC_TIMER     ; x05
  JMP TRAP_RESET_VMEM	  ; x06
  JMP TRAP_BLT_VMEM	      ; x07
  JMP TRAP_DRAW_PIXEL     ; x08
  JMP TRAP_DRAW_RECT      ; x09
  JMP TRAP_DRAW_SPRITE    ; x0A
  JMP TRAP_LFSR_SET_SEED  ; x0B
  JMP TRAP_LFSR           ; x0C

  ;
  ; TO DO - add additional vectors as described in homework 
  ;
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;   OS - MEMORY ADDRESSES & CONSTANTS   ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; these handy alias' will be used in the TRAPs that follow
  USER_CODE_ADDR .UCONST x0000	; start of USER code
  OS_CODE_ADDR 	 .UCONST x8000	; start of OS code

  OS_GLOBALS_ADDR .UCONST xA000	; start of OS global mem
  OS_STACK_ADDR   .UCONST xBFFF	; start of OS stack mem

  OS_KBSR_ADDR .UCONST xFE00  	; alias for keyboard status reg
  OS_KBDR_ADDR .UCONST xFE02  	; alias for keyboard data reg

  OS_ADSR_ADDR .UCONST xFE04  	; alias for display status register
  OS_ADDR_ADDR .UCONST xFE06  	; alias for display data register

  OS_TSR_ADDR .UCONST xFE08 	; alias for timer status register
  OS_TIR_ADDR .UCONST xFE0A 	; alias for timer interval register

  OS_VDCR_ADDR	.UCONST xFE0C	; video display control register
  OS_MCR_ADDR	.UCONST xFFEE	; machine control register
  OS_VIDEO_NUM_COLS .UCONST #128
  OS_VIDEO_NUM_ROWS .UCONST #124


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; OS DATA MEMORY RESERVATIONS ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xA000
OS_GLOBALS_MEM	.BLKW x1000
;;;  LFSR value used by lfsr code
LFSR .FILL 0x0001

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; OS VIDEO MEMORY RESERVATION ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xC000
OS_VIDEO_MEM .BLKW x3E00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;   OS & TRAP IMPLEMENTATIONS BEGIN HERE   ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x8200
.FALIGN
  ;; first job of OS is to return PennSim to x0000 & downgrade privledge
  CONST R7, #0   ; R7 = 0
  RTI            ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - none
;;; Outputs          - R0 = ASCII character from ASCII keyboard

.CODE
TRAP_GETC
    LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
    LDR R0, R0, #0       ; R0 = value of keyboard status reg
    BRzp TRAP_GETC       ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

    LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
    LDR R0, R0, #0       ; R0 = value of keyboard data reg
    RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a single character out to ASCII display
;;; Inputs           - R0 = ASCII character to write to ASCII display
;;; Outputs          - none

.CODE
TRAP_PUTC
  LC R1, OS_ADSR_ADDR 	; R1 = address of display status reg
  LDR R1, R1, #0    	; R1 = value of display status reg
  BRzp TRAP_PUTC    	; if R1[15]=1, display is ready to write!
		    	    ; else, loop and check again...

  ; reaching here, means console is ready to display next char

  LC R1, OS_ADDR_ADDR 	; R1 = address of display data reg
  STR R0, R1, #0    	; R1 = value of keyboard data reg (R0)
  RTI			; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a string of characters from the ASCII keyboard
;;; Inputs           - R0 = Address to place characters from keyboard
;;; Outputs          - R1 = Lenght of the string without the NULL

.CODE
TRAP_GETS

  CONST R3, x00
  HICONST R3, x20
  CMPU R0, R3    ; sets  NZP (R0 - x2000)
  BRn END_LOOP2    ; tests NZP (checks if the address at R0 is at least x2000, if no, return)
  CONST R3, x7F
  HICONST R3, xFF
  CMPU R0, R3     ; sets  NZP (R0 - x7FFF)
  BRp END_LOOP2    ; tests NZP (checks if the address at R0 is at most x7FFF, if no, return)
  CONST R1, #0 ; Set R1 to 0
  LOOP2
  LC R2, OS_KBSR_ADDR  ; R2 = address of keyboard status reg
    LDR R2, R2, #0       ; R2 = value of keyboard status reg
    BRzp LOOP2       ; if R2[15]=1, data is waiting!
                             ; else, loop and check again...
	  LC R2, OS_KBDR_ADDR  ; R2 = address of keyboard data reg
    LDR R2, R2, #0       ; R2 = value of keyboard data reg
    CMPI R2, x0A     ; Check if the key press is enter
    BRz END_LOOP2     ; If it is, leave the loop
    STR R2, R0, #0   ; If not, store R2 in R0
    ADD R0, R0, #1        ; Increment regester by 1
    ADD R1, R1, #1        ; Increase length by 1
    BRnzp LOOP2       ; Always go to LOOP2
  END_LOOP2
  CONST R3, #0 ; Set R3 to 0
  STR R3, R0, #0 ; Store R3 in R0 (null)
  CONST R4, x30
  ADD R3, R1, R4 ; Store the length in R3
  ADD R0, R0, #1 ; Increment register by 1
  STR R3, R0, #0 ; Store R3 in R0
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a string of characters out to ASCII display
;;; Inputs           - R0 = Address for first character
;;; Outputs          - none

.CODE
TRAP_PUTS
  CONST R3, x00
  HICONST R3, x20
  CMPU R0, R3    ; sets  NZP (R0 - x2000)
  BRn END_LOOP    ; tests NZP (checks if the address at R0 is at least x2000, if no, return)
  CONST R3, x7F
  HICONST R3, xFF
  CMPU R0, R3     ; sets  NZP (R0 - x7FFF)
  BRp END_LOOP    ; tests NZP (checks if the address at R0 is at most x7FFF, if no, return)

  LC R1, OS_ADDR_ADDR 	; R1 = address of display status reg
  LOOP
    LDR R2, R0, #0    ; Load value of R0 into R2
    CMPI R2, 0      ; Checks if the value at R2 is null
    BRz END_LOOP        ; If it is, exit the loop
    
    STR R2, R1, #0    	; R1 = value of keyboard data reg (R2)
    ADD R0, R0, #1       ; Increment the register of R0 by 1
    BRnzp LOOP          ; Always go to LOOP
  END_LOOP
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function:
;;; Inputs           - R0 = time to wait in milliseconds
;;; Outputs          - none

.CODE
TRAP_TIMER
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

COUNT
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRzp COUNT    	; If R1[15]=1, timer has gone off!

  ; reaching this line means we've finished counting R0

  RTI       		; PC = R7 ; PSR[15]=0



;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - R0 = time to wait
;;; Outputs          - R0 = ASCII character from keyboard (or NULL)

.CODE
TRAP_GETC_TIMER

  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

COUNT2
  LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
  LDR R0, R0, #0       ; R0 = value of keyboard status reg
  BRn PRESSED       ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRzp COUNT2    	; If R1[15]=1, timer has gone off!

  ; reaching this line means we've finished counting R0
  CONST R0, #0   ; Return null if no key pressed
  BRnzp NOT_PRESSED
  PRESSED
  LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
  LDR R0, R0, #0       ; R0 = value of keyboard data reg
  NOT_PRESSED
  RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TRAP_RESET_VMEM ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; In double-buffered video mode, resets the video display
;;; DO NOT MODIFY this trap, it's for future HWs
;;; Inputs - none
;;; Outputs - none
.CODE	
TRAP_RESET_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #1
  STR R5, R4, #0
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TRAP_BLT_VMEM ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_BLT_VMEM - In double-buffered video mode, copies the contents
;;; of video memory to the video display.
;;; DO NOT MODIFY this trap, it's for future HWs
;;; Inputs - none
;;; Outputs - none
.CODE
TRAP_BLT_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #2
  STR R5, R4, #0
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_PIXEL   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw point on video display
;;; Inputs           - R0 = row to draw on (y)
;;;                  - R1 = column to draw on (x)
;;;                  - R2 = color to draw with
;;; Outputs          - none

.CODE
TRAP_DRAW_PIXEL
  LEA R3, OS_VIDEO_MEM       ; R3=start address of video memory
  LC  R4, OS_VIDEO_NUM_COLS  ; R4=number of columns

  CMPIU R1, #0    	         ; Checks if x coord from input is > 0
  BRn END_PIXEL
  CMPIU R1, #127    	     ; Checks if x coord from input is < 127
  BRp END_PIXEL
  CMPIU R0, #0    	         ; Checks if y coord from input is > 0
  BRn END_PIXEL
  CMPIU R0, #123    	     ; Checks if y coord from input is < 123
  BRp END_PIXEL

  MUL R4, R0, R4      	     ; R4= (row * NUM_COLS)
  ADD R4, R4, R1      	     ; R4= (row * NUM_COLS) + col
  ADD R4, R4, R3      	     ; Add the offset to the start of video memory
  STR R2, R4, #0      	     ; Fill in the pixel with color from user (R2)

END_PIXEL
  RTI       		         ; PC = R7 ; PSR[15]=0
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_RECT   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw a rectangle given x and y coordinates, length, width, and color
;;; Inputs    - R0 = x-coordinate
;;;           - R1 = y-coordinate 
;;;           - R2 = length 
;;;           - R3 = width 
;;;           - R4 = color
;;; Outputs   - none

.CODE
TRAP_DRAW_RECT
  LC R6, OS_GLOBALS_ADDR ; Store R5 into global memory, used when returning from trap
  STR R5, R6, #20 ; Store the value in R5 in global memory space

  ADD R5, R0, R3 ; Set R5 to the max x coordinate
  ADD R6, R1, R2 ; Set R6 to the max y coordinate
  CMPIU R0, #0    	         ; Checks if x coord from input is > 0
  BRn END_RECT               ; If not, don't draw rectangle
  CMPIU R5, #127    	     ; Checks if max x coord from input is < 127
  BRp END_RECT
  CMPIU R1, #0    	         ; Checks if y coord from input is > 0
  BRn END_RECT
  CMPIU R6, #123    	     ; Checks if max y coord from input is < 123
  BRp END_RECT

  LOOP3
    LC  R6, OS_VIDEO_NUM_COLS  ; R6=number of columns
    ADD R5, R1, R2             ; Set R5 to the last row of the rectangle to be drawn
    MUL R5, R5, R6      	     ; R5= (row * NUM_COLS)
    ADD R5, R5, R0      	     ; R5= (row * NUM_COLS) + col
    ADD R5, R5, R3      	     ; R5= (row * NUM_COLS) + col + width
    LEA R6, OS_VIDEO_MEM       ; R6=start address of video memory
    ADD R5, R5, R6      	     ; Add the offset to the start of video memory
    ADD R6, R3, #0 ; Set R6 to be the width of rectangle to help draw pixels

    LOOP4
      STR R4, R5, #0      	     ; Fill in the pixel with color from user (R4)
      ADD R5, R5, #-1            ; Decrease R5 by 1
      ADD R6, R6, #-1            ; Decrease R6 by 1
      CMPIU R6, #0               ; Checks if R6 <= 0
      BRp LOOP4                 ; If not, go back to LOOP4
    ADD R2, R2, #-1            ; Decrease R2 by 1
    CMPIU R2, #0               ; Checks if R2 <= 0
    BRp LOOP3                ; If not, go back to LOOP3
    
  END_RECT
  LC R6, OS_GLOBALS_ADDR ; Restore R5 into global memory
  LDR R5, R6, #20 ; Load the value in R6 into R5
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_SPRITE   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw a sprite given x and y coordinates, color, and pattern
;;; Inputs    - R0 = x-coordinate
;;;           - R1 = y-coordinate 
;;;           - R2 = color 
;;;           - R3 = starting address of pattern
;;; Outputs   - none

.CODE
TRAP_DRAW_SPRITE
    LC R6, OS_GLOBALS_ADDR ; Store R5 into global memory, used when returning from trap
    STR R5, R6, #20 ; Store the value in R5 in global memory space

    LC R6, OS_GLOBALS_ADDR    ; location of global memory
    ADD R6, R6, #2 ; Go to 3rd global memory space
    CONST R5, #0   ; Set R5 to 0
    STR R5, R6, #0 ; Store the value 0 in 3rd global memory space
    ADD R6, R6, #1 ; Go to 4th global memory space
    CONST R5, #0   ; Set R5 to 0
    STR R5, R6, #0 ; Store the value 0 in 4th global memory space

  LOOP5

    LC R6, OS_GLOBALS_ADDR    ; location of global memory
    ADD R6, R6, #3 ; Go to 4th global memory space
    CONST R5, #0   ; Set R5 to 0
    STR R5, R6, #0 ; Store the value 0 in 4th global memory space

    LC R6, OS_GLOBALS_ADDR    ; location of global memory
    ADD R6, R6, #2            ; Go to 3rd space in memory
    LDR R5, R6, #0            ; Load the data in R5
    CONST R4, #0              ; Set R4 to 0
    ADD R4, R4, R5             ; Set R4 to the row of the sprite to be drawn
    ADD R4, R4, R1             
    LC R5, OS_VIDEO_NUM_COLS   ; R5=number of columns
    MUL R4, R4, R5      	     ; R4= (row * NUM_COLS)

    CMPI R0, #0                ; If R0 is negative, don't add
    BRn DONT_ADD
    ADD R4, R4, R0      	     ; R4= (row * NUM_COLS) + col
    BRnzp ADDED
    DONT_ADD
    LC R6, OS_GLOBALS_ADDR    ; location of global memory
    ADD R6, R6, #3            ; Go to 4th space in memory
    LDR R5, R6, #0            ; Load the data in R5
    SUB R5, R5, R0            ; Subtract R0 from R5 (adds the magnitude of R0 since R0 is negative)
    STR R5, R6, #0            ; Store the value in global memory
    ADDED

    LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
    ADD R4, R4, R5      	     ; Add the offset to the start of video memory

    LDR R5, R3, #0 ; Load the data from R3 into R5
    SLL R5, R5, #8 ; Shift the data at R5 left by 8 bits

    ;; Code to prevent drawing parts of sprite that are off-screen
    CMPI R0, #0    ; If x coordinate is negative, shift extra bits
    BRzp DONT_SHIFT ; If not, don't shift
    CONST R6, #-1 ; Set R6 to -1 to flip sign of R0
    MUL R6, R6, R0 ; R6 = -1 * R0
    SHIFT_LOOP
      SLL R5, R5, #1 ; Shift the data at R5 left by 1 bit
      ADD R6, R6, #-1 ; Decrease R6 by 1
      CMPI R6, #0 ; Check if R6 is positive
      BRp SHIFT_LOOP ; If it is, go to SHIFT_LOOP
    DONT_SHIFT

    LC R6, OS_GLOBALS_ADDR    ; location of global memory
    ADD R6, R6, #1 ; Go to 2nd space
    STR R5, R6, #0 ; Store the data in 2nd global memory space

    LOOP6
      ADD R5, R4, #0 ; Set R5 to R4
      LEA R6, OS_VIDEO_MEM       ; R6=start address of video memory
      CMP R5, R6                ; Check the value of R5-R6
      BRn NOT_IN_VIDEO_MEM       ; If negative, R4 is not an address in video memory
      LC R6, OS_VIDEO_NUM_ROWS   ; R6=number of rows
      LC R5, OS_VIDEO_NUM_COLS   ; R5=number of columns
      MUL R5, R6, R5      	     ; R5= (NUM_ROWS * NUM_COLS)
      LEA R6, OS_VIDEO_MEM       ; R6=start address of video memory
      ADD R5, R5, R6      	     ; Add the offset to the start of video memory
      SUB R5, R4, R5             ; Subtract the largest register in video memory from R4
      CMPI R5, #0                
      BRp NOT_IN_VIDEO_MEM       ; If positive, the register is not in video memory

      LC R6, OS_GLOBALS_ADDR    ; location of global memory
      ADD R6, R6, #1 ; Go to 2nd space
      LDR R5, R6, #0 ; Load the value at R6 into R5
      CMPI R5, #0  ; Check if the current bit is a 0 or 1
      BRzp SKIP ; If it is a 0, skip
      STR R2, R4, #0 ; If it is not, fill in the current pixel
      SKIP

      ADD R4, R4, #1 ; Increase R4 by 1
      SLL R5, R5, #1 ; Shift the data at R5 left by 1 bit
      LC R6, OS_GLOBALS_ADDR    ; location of global memory
      ADD R6, R6, #1 ; Go to 2nd space
      STR R5, R6, #0 ; Store the data in 2nd global memory space

      LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
      SUB R4, R4, R5             ; Subtract to find current position in video memory
      LC R5, OS_VIDEO_NUM_COLS   ; R5=number of columns
      MOD R5, R4, R5             ; Check if it reached the leftmost position
      BRz OUT_OF_BOUNDS          ; If yes, stop drawing this row
      LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
      ADD R4, R4, R5             ; Add the offset back to R4 to fix the change when checking if out of bounds
      LC R6, OS_GLOBALS_ADDR    ; location of global memory

      NOT_IN_VIDEO_MEM

      ADD R6, R6, #3 ; Go to 4th global memory space
      LDR R5, R6, #0 ; Load the data from R6 into R5
      ADD R5, R5, #1 ; Increase the value of the counter by 1
      STR R5, R6, #0 ; Store the new value in the same global memory space
      CMPIU R5, #8 ; Checks if R5 >= 8
      BRn LOOP6 ; If not, go back to LOOP6

      BRnzp FINISHED_LOOP6 ; Otherwise, skip OUT_OF_BOUNDS
    OUT_OF_BOUNDS
    LEA R5, OS_VIDEO_MEM       ; R5=start address of video memory
    ADD R4, R4, R5             ; Add the offset to R4 to fix the change when checking if out of bounds
    FINISHED_LOOP6

    ADD R3, R3, #1 ; Add 1 to the address currently being processed
    LC R6, OS_GLOBALS_ADDR    ; location of global memory
    ADD R6, R6, #2 ; Go to 3rd global memory space
    LDR R5, R6, #0 ; Load the data from R6 into R5
    ADD R5, R5, #1 ; Increase the value of the counter by 1
    STR R5, R6, #0 ; Store the new value in the samce global memory space
    CMPIU R5, #8 ; Checks if R5 >= 8
    BRn LOOP5 ; If not, go back to LOOP5
    
  END_SPRITE
  LC R6, OS_GLOBALS_ADDR ; Restore R5 into global memory
  LDR R5, R6, #20 ; Load the value in R6 into R5
  RTI


;; TO DO: Add TRAPs in HW

;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_LFSR_SET_SEED   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Sets a seed for the LFSR subroutine
;;; Inputs    - R0 = 16 bit number
;;; Outputs   - none

.CODE
TRAP_LFSR_SET_SEED
  LC R6, OS_GLOBALS_ADDR    ; location to store the LFSR
  STR R0, R6, #0 ; Store the data at R0 into R6
RTI



;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_LFSR   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Generates a pseudo-random number by the LFSR algorithm
;;; Inputs    - none
;;; Outputs   - R0 pseudo random number generated by the algorithm

.CODE
TRAP_LFSR
LC R6, OS_GLOBALS_ADDR    ; location to store the LFSR
  LDR R0, R6, #0 ; Load the data at R0 into R6

    CMPIU R0, #0 ; Check if R0 is 0
    BRp SKIP_DEFAUlT_VALUE ; If not, skip
    CONST R0, #10; Set R0 to 10 if it is 0
    SKIP_DEFAULT_VALUE

    ADD R4, R0, #0  ; Set R4 to the same value as R0
    
    SRL R4, R0, #10  ; Shift the bits in R0 right 10 bits
    CONST R3, #2      ; Set variable for the number 2 to perform modulo
    MOD R2, R4, R3  ; Check if 10th bit is 0 or 1 and store it in R2

    SRL R4, R0, #12  ; Shift the bits in R0 right 12 bits
    CONST R3, #2      ; Set variable for the number 2 to perform modulo
    MOD R3, R4, R3  ; Check if 12th bit is 0 or 1 and store it in R3
    XOR R2, R2, R3  ; XOR R2 and R3 and store it in R2

    SRL R4, R0, #13  ; Shift the bits in R4 right 13 bits
    CONST R3, #2      ; Set variable for the number 2 to perform modulo
    MOD R3, R4, R3  ; Check if 13th bit is 0 or 1 and store it in R3
    XOR R2, R2, R3  ; XOR R2 and R3 and store it in R2

    SRL R4, R0, #15  ; Shift the bits in R4 right 15 bits
    CONST R3, #2      ; Set variable for the number 2 to perform modulo
    MOD R3, R4, R3  ; Check if 13th bit is 0 or 1 and store it in R3
    XOR R2, R2, R3  ; XOR R2 and R3 and store it in R2

    
    SLL R3, R0, #1  ; Shift the bits in R0 left 1 bit

    ADD R3, R3, R2  ; Add R2 to R3

    ADD R0, R3, #0  ; Set R0 to equal R3

    STR R0, R6, #0  ; Store the value in R0 into R6
  RTI