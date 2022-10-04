;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : factorial_sub.asm                      ;
;  author      : 
;  description : LC4 Assembly subroutine to compute the ;
;                factorial of a number                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;

;; TO-DO:
;; 1) Open up the codio assignment where you created the factorial subroutine (in a separate browswer window)
;; 2) In that window, open up your working factorial_sub.asm file:
;;    -select everything in the file, and "copy" this content (Conrol-C) 
;; 3) Return to the current codio assignment, paste the content into this factorial_sub.asm 
;;    -now you can use the factorial_sub.asm from your last HW in this HW
;; 4) Save the updated factorial_sub.asm file

.FALIGN
SUB_FACTORIAL
    ;; prologue
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

    ADD R6, R6, #-3 ; Allocate space for local variables, B, C, D
    CONST R1, #-1    ; B = -1
    STR R1, R5, #-1 ; store B = -1 on stack
    CONST R2, #0    ; C = 0
    STR R2, R5, #-2 ; store C = 0 on stack
    CONST R3, #0    ; D = 0
    STR R3, R5, #-3 ; store D = 0 on stack
    LDR R0, R5, #3  ; taking in argument, A, and loading into R0

    ;; function body
  
  CMPI R0, #0     ; sets  NZP (A-0)
  BRn END_SUB_FACTORIAL    ; tests NZP (was A-0 neg?, if yes, goto END_SUB_FACTORIAL, returning B as -1)
  CMPI R0, #7     ; sets  NZP (A-7)
  BRp END_SUB_FACTORIAL    ; tests NZP (was A-7 pos?, if yes, goto END_SUB_FACTORIAL since answer will be inaccurate, returning B as -1)
  CONST R1, #1    ; B = 1
  STR R1, R5, #-1 ; update B on stack
  CMPI R0, #0     ; sets  NZP (A-0)
  BRz END_SUB_FACTORIAL    ; tests NZP, (was A-0 zero?, if yes, goto END_SUB_FACTORIAL, returning B as 1)
  ADD R1, R0, #0  ; B = A+0
  STR R1, R5, #-1 ; update B on stack
  LOOP              
    CMPI R0, #1     ; sets  NZP (A-1)
    BRnz END_SUB_FACTORIAL      ; tests NZP (was A-1 neg or zero?, if yes, goto END_SUB_FACTORIAL)
    ADD R0, R0, #-1 ; A=A-1

    ; register allocation: R2 = C, R3 = D
    CONST R2, #0    ; C = 0
    ADD R2, R0, #0  ; C = A+0
    STR R2, R5, #-2 ; update C on stack
    CONST R3, #0    ; D = 0
    ADD R3, R1, #0  ; D = B+0
    STR R3, R5, #-3 ; update D on stack
    LOOP2             ; Loops to perform multiplication with current values of A and B
      CMPI R2, #1     ; sets  NZP (C-1)
      BRnz END2       ; tests NZP (was C-1 neg or zero?, if yes, goto END2)
      ADD R1, R1, R3  ; B=B+D
      STR R1, R5, #-1 ; update B on stack
      ADD R2, R2, #-1 ; C=C-1
      STR R2, R5, #-2 ; update C on stack
      BRnzp LOOP2     ; always goto LOOP2
    END2
    BRnzp LOOP        ; always goto LOOP
  END_SUB_FACTORIAL
  
  ;; epilogue
  ADD R6, R5, #0 ; pop local variables
  ADD R6, R6, #3 ; decrease stack
  STR R1, R6, #-1 ; update B as the return value
  LDR R5, R6, #-3 ; restore base pointer
  LDR R7, R6, #-2 ; restore R7 for RET
  RET