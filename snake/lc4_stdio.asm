;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : lc4_stdio.asm                          ;
;  author      : 
;  description : LC4 Assembly subroutines that call     ;
;                call the TRAPs in os.asm (the wrappers);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; WRAPPER SUBROUTINES FOLLOW ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
.CODE
.ADDR x0010    ;; this code should be loaded after line 10
               ;; this is done to preserve "USER_START"
               ;; subroutine that calls "main()"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_putc

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	
		
	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument, A, and loading into R0
		
	TRAP x01        ; R0 must be set before TRAP_PUTC is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer
		
	;; FUNCTION BODY ;;
		
	TRAP x00        ; Call's TRAP_GETC 
                    ; R0 will contain ascii character from keyboard
                    ; you must copy this back to the stack
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	STR R0, R6, #-1 ; Set value at R0 as the return value
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET

RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_RESET_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_reset_vmem

    ;; STUDENTS - DON'T edit these wrappers - they must be here to get PennSim to work in double-buffer mode
    ;;          - DON'T use their prologue or epilogue's as models - use the slides!!
  
    ;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	;; no arguments
	TRAP x06
	;; epilogue
	LDR R5, R6, #0
	LDR R7, R6, #1
	ADD R6, R6, #2
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_BLT_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_blt_vmem

    ;; STUDENTS - DON'T edit these wrappers - they must be here to get PennSim to work in double-buffer mode
    ;;          - DON'T use their prologue or epilogue's as models - use the slides!!

	;; prologue
	ADD R6, R6, #-2
	STR R5, R6, #0
	STR R7, R6, #1
	;; no arguments
	TRAP x07
	;; epilogue
	LDR R5, R6, #0
	LDR R7, R6, #1
	ADD R6, R6, #2
RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_puts

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
		
	TRAP x03        ; R0 must be set before TRAP_PUTS is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_gets

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
		
	TRAP x02        ; R0 must be set before TRAP_GETS is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	STR R1, R6, #-1 ; Set value at R1 as the return value
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_TIMER Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_timer

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
		
	TRAP x04        ; R0 must be set before TRAP_TIMER is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRAP_GETC_TIMER Wrapper ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc_timer

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
		
	TRAP x05        ; R0 must be set before TRAP_GETC_TIMER is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	STR R0, R6, #-1 ; Set value at R0 as the return value
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRAP_DRAW_PIXEL Wrapper ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_pixel

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
	LDR R1, R5, #4  ; taking in argument and loading into R1
	LDR R2, R5, #5  ; taking in argument and loading into R2
		
	TRAP x08        ; arguments must be set before TRAP_DRAW_PIXEL is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRAP_DRAW_RECT Wrapper ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_rect

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
	LDR R1, R5, #4  ; taking in argument and loading into R1
	LDR R2, R5, #5  ; taking in argument and loading into R2
	LDR R3, R5, #6  ; taking in argument and loading into R3
	LDR R4, R5, #7  ; taking in argument and loading into R4
		
	TRAP x09        ; arguments must be set before TRAP_DRAW_RECT is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRAP_DRAW_SPRITE Wrapper ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_sprite

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
	LDR R1, R5, #4  ; taking in argument and loading into R1
	LDR R2, R5, #5  ; taking in argument and loading into R2
	LDR R3, R5, #6  ; taking in argument and loading into R3
		
	TRAP x0A        ; arguments must be set before TRAP_DRAW_SPRITE is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;TRAP_LFSR_SET_SEED Wrapper;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_lfsr_set_seed

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer

	;; FUNCTION BODY ;;
	LDR R0, R5, #3  ; taking in argument and loading into R0
		
	TRAP x0B        ; R0 must be set before TRAP_LFSR_SET_SEED is called
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
	CONST R1, #0    ; update 0 as the return value
  	STR R1, R6, #-1
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_LFSR Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_lfsr

	;; PROLOGUE ;;
    STR R7, R6, #-2 ; save caller's return address
    STR R5, R6, #-3 ; save caller's frame pointer
    ADD R6, R6, #-3 ; updates stack pointer
    ADD R5, R6, #0  ; updates frame pointer
		
	;; FUNCTION BODY ;;
		
	TRAP x0C        ; Call's TRAP_LFSR
	
	;; EPILOGUE ;; 
	ADD R6, R5, #0 ; pop local variables
  	ADD R6, R6, #3 ; decrease stack
  	STR R0, R6, #-1 ; Set value at R0 as the return value
  	LDR R5, R6, #-3 ; restore base pointer
  	LDR R7, R6, #-2 ; restore R7 for RET

RET