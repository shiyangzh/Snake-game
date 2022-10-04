		.DATA
timer 		.FILL #150
;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L2_snake
	LEA R7, L4_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_snake
L2_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L6_snake
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L7_snake
L6_snake
	LDR R7, R5, #3
	STR R7, R5, #-13
L7_snake
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L8_snake
	LEA R7, L10_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L1_snake
L8_snake
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L12_snake
L11_snake
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L12_snake
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L11_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L14_snake
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L14_snake
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L1_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L17_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L16_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L18_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
zero 		.FILL #255
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.DATA
one 		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.DATA
two 		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.DATA
three 		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.DATA
four 		.FILL #195
		.FILL #195
		.FILL #195
		.FILL #255
		.FILL #3
		.FILL #3
		.FILL #3
		.FILL #3
		.DATA
five 		.FILL #255
		.FILL #255
		.FILL #224
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #255
		.FILL #255
		.DATA
six 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.DATA
seven 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.DATA
eight 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.DATA
nine 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_length
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, snake_direction
	CONST R3, #3
	STR R3, R7, #0
	LEA R7, snake
	CONST R3, #10
	STR R3, R7, #0
	STR R3, R7, #1
L19_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_bombs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_bombs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, bombs_count
	CONST R3, #0
	STR R3, R7, #0
L20_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;turn_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
turn_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L22_snake
	LDR R7, R5, #3
	CONST R3, #1
	CMP R7, R3
	BRz L22_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
	JMP L23_snake
L22_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L24_snake
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRz L24_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
	JMP L25_snake
L24_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRnp L26_snake
	LDR R7, R5, #3
	CONST R3, #3
	CMP R7, R3
	BRz L26_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
	JMP L27_snake
L26_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #3
	CMP R7, R3
	BRnp L28_snake
	LDR R7, R5, #3
	CONST R3, #2
	CMP R7, R3
	BRz L28_snake
	LEA R7, snake_direction
	LDR R3, R5, #3
	STR R3, R7, #0
L28_snake
L27_snake
L25_snake
L23_snake
L21_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;grow_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
grow_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, snake_length
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, snake
	ADD R2, R7, R3
	ADD R3, R3, #-2
	ADD R7, R7, R3
	LDR R7, R7, #0
	STR R7, R2, #0
	LEA R7, snake_length
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, snake
	ADD R2, R7, R3
	ADD R3, R3, #-2
	ADD R7, R7, R3
	LDR R7, R7, #1
	STR R7, R2, #1
	LEA R7, snake_length
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L30_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;move_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
move_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	LEA R7, snake
	LDR R7, R7, #0
	STR R7, R5, #-2
	LEA R7, snake
	LDR R7, R7, #1
	STR R7, R5, #-3
	CONST R7, #1
	STR R7, R5, #-1
	JMP L35_snake
L32_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R7, #0
	STR R3, R5, #-4
	LDR R3, R7, #1
	STR R3, R5, #-5
	LDR R3, R5, #-2
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #1
	LDR R7, R5, #-4
	STR R7, R5, #-2
	LDR R7, R5, #-5
	STR R7, R5, #-3
L33_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L35_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMP R7, R3
	BRn L32_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L36_snake
	LEA R7, snake
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRnp L38_snake
	CONST R7, #0
	JMP L31_snake
L38_snake
	LEA R7, snake
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L37_snake
L36_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L40_snake
	LEA R7, snake
	LDR R7, R7, #1
	CONST R3, #14
	CMP R7, R3
	BRnp L42_snake
	CONST R7, #0
	JMP L31_snake
L42_snake
	LEA R7, snake
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L41_snake
L40_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRnp L44_snake
	LEA R7, snake
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L46_snake
	CONST R7, #0
	JMP L31_snake
L46_snake
	LEA R7, snake
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L45_snake
L44_snake
	LEA R7, snake_direction
	LDR R7, R7, #0
	CONST R3, #3
	CMP R7, R3
	BRnp L48_snake
	LEA R7, snake
	LDR R7, R7, #0
	CONST R3, #15
	CMP R7, R3
	BRnp L50_snake
	CONST R7, #0
	JMP L31_snake
L50_snake
	LEA R7, snake
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L48_snake
L45_snake
L41_snake
L37_snake
	CONST R7, #1
L31_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_fruit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_fruit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-2
	JMP L54_snake
L53_snake
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #16
	MOD R7, R7, R3
	STR R7, R5, #-3
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #15
	MOD R7, R7, R3
	STR R7, R5, #-4
	CONST R7, #0
	STR R7, R5, #-1
	JMP L59_snake
L56_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	STR R7, R5, #-5
	LDR R3, R5, #-3
	LDR R2, R7, #0
	CMP R3, R2
	BRnp L60_snake
	LDR R7, R5, #-4
	LDR R3, R5, #-5
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L60_snake
	CONST R7, #0
	STR R7, R5, #-2
L60_snake
L57_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L59_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L56_snake
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L62_snake
	LEA R7, fruit
	LDR R3, R5, #-3
	STR R3, R7, #0
	LDR R3, R5, #-4
	STR R3, R7, #1
	JMP L52_snake
L62_snake
L54_snake
	JMP L53_snake
L52_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;spawn_bomb;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
spawn_bomb
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-2
	JMP L66_snake
L65_snake
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #16
	MOD R7, R7, R3
	STR R7, R5, #-3
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #15
	MOD R7, R7, R3
	STR R7, R5, #-4
	CONST R7, #0
	STR R7, R5, #-1
	JMP L71_snake
L68_snake
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	STR R7, R5, #-5
	LDR R3, R5, #-3
	LDR R2, R7, #0
	CMP R3, R2
	BRnp L72_snake
	LDR R7, R5, #-4
	LDR R3, R5, #-5
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L72_snake
	CONST R7, #0
	STR R7, R5, #-2
L72_snake
L69_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L71_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L68_snake
	LEA R7, fruit
	STR R7, R5, #-5
	LDR R3, R5, #-3
	LDR R2, R7, #0
	CMP R3, R2
	BRnp L74_snake
	LDR R7, R5, #-4
	LDR R3, R5, #-5
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L74_snake
	CONST R7, #0
	STR R7, R5, #-2
L74_snake
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L76_snake
	LEA R7, bombs_count
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #0
	LEA R7, bombs_count
	LDR R7, R7, #0
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R5, #-4
	STR R3, R7, #1
	LEA R7, bombs_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L64_snake
L76_snake
L66_snake
	JMP L65_snake
L64_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_bomb_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_bomb_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L82_snake
L79_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	LEA R2, bomb
	ADD R3, R3, R2
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L83_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L83_snake
	CONST R7, #2
	JMP L78_snake
L83_snake
L80_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L82_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L79_snake
	CONST R7, #0
L78_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_fruit_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_fruit_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, snake
	STR R7, R5, #-1
	LEA R3, fruit
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L86_snake
	LDR R7, R5, #-1
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L86_snake
	CONST R7, #3
	JMP L85_snake
L86_snake
	CONST R7, #0
L85_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_self_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_self_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #1
	STR R7, R5, #-1
	JMP L92_snake
L89_snake
	LEA R7, snake
	STR R7, R5, #-2
	LDR R3, R5, #-1
	SLL R3, R3, #1
	ADD R3, R3, R7
	LDR R2, R7, #0
	LDR R1, R3, #0
	CMP R2, R1
	BRnp L93_snake
	LDR R7, R5, #-2
	LDR R7, R7, #1
	LDR R3, R3, #1
	CMP R7, R3
	BRnp L93_snake
	CONST R7, #4
	JMP L88_snake
L93_snake
L90_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L92_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMP R7, R3
	BRn L89_snake
	CONST R7, #0
L88_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;handle_collisions;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
handle_collisions
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR check_bomb_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #2
	CMP R7, R3
	BRnp L96_snake
	CONST R7, #2
	JMP L95_snake
L96_snake
	JSR check_fruit_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	CMP R7, R3
	BRnp L98_snake
	CONST R7, #3
	JMP L95_snake
L98_snake
	JSR check_self_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #4
	CMP R7, R3
	BRnp L100_snake
	CONST R7, #4
	JMP L95_snake
L100_snake
	CONST R7, #0
L95_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	JSR move_snake
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L103_snake
	CONST R7, #2
	JMP L102_snake
L103_snake
	JSR handle_collisions
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	STR R7, R5, #-3
	CONST R3, #2
	CMP R7, R3
	BRz L107_snake
	CONST R7, #4
	LDR R3, R5, #-3
	CMP R3, R7
	BRnp L105_snake
L107_snake
	CONST R7, #2
	JMP L102_snake
L105_snake
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRnp L108_snake
	JSR grow_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR spawn_fruit
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #25
	CMP R7, R3
	BRn L110_snake
	CONST R7, #1
	JMP L102_snake
L110_snake
	LEA R7, snake_length
	LDR R7, R7, #0
	CONST R3, #5
	MOD R7, R7, R3
	CONST R3, #0
	CMP R7, R3
	BRnp L112_snake
	JSR spawn_bomb
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, L114_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, timer
	LDR R3, R7, #0
	CONST R2, #30
	SUB R3, R3, R2
	STR R3, R7, #0
	LDR R7, R7, #0
	CONST R3, #35
	CMP R7, R3
	BRzp L115_snake
	LEA R7, timer
	CONST R3, #35
	STR R3, R7, #0
L115_snake
L112_snake
L108_snake
	CONST R7, #0
L102_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;index_to_pixel;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
index_to_pixel
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	SLL R7, R7, #3
L117_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_pixel;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_pixel
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR index_to_pixel
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR index_to_pixel
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-2
	LDR R7, R5, #5
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_rect
	ADD R6, R6, #5	;; free space for arguments
L118_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_snake;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_snake
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	HICONST R7, #51
	STR R7, R5, #-2
	CONST R7, #0
	STR R7, R5, #-1
	JMP L123_snake
L120_snake
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, snake
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L121_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L123_snake
	LDR R7, R5, #-1
	LEA R3, snake_length
	LDR R3, R3, #0
	CMP R7, R3
	BRn L120_snake
L119_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_bombs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_bombs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #255
	HICONST R7, #255
	STR R7, R5, #-2
	CONST R7, #0
	STR R7, R5, #-1
	JMP L128_snake
L125_snake
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LEA R3, bomb
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L126_snake
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L128_snake
	LDR R7, R5, #-1
	LEA R3, bombs_count
	LDR R3, R3, #0
	CMP R7, R3
	BRn L125_snake
L124_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_fruit;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_fruit
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	HICONST R7, #124
	STR R7, R5, #-1
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, fruit
	LDR R3, R7, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L129_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;display_score;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
display_score
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
L130_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_bombs
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_fruit
	ADD R6, R6, #0	;; free space for arguments
	JSR display_score
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L131_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;play_game;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
play_game
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	CONST R7, #0
	STR R7, R5, #-2
	LEA R7, timer
	CONST R3, #150
	STR R3, R7, #0
	JSR init_snake
	ADD R6, R6, #0	;; free space for arguments
	JSR spawn_fruit
	ADD R6, R6, #0	;; free space for arguments
	JSR reset_bombs
	ADD R6, R6, #0	;; free space for arguments
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
	JMP L134_snake
L133_snake
	LEA R7, timer
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #105
	CMP R7, R3
	BRnp L136_snake
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	JMP L137_snake
L136_snake
	LDR R7, R5, #-2
	CONST R3, #107
	CMP R7, R3
	BRnp L138_snake
	CONST R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	JMP L139_snake
L138_snake
	LDR R7, R5, #-2
	CONST R3, #106
	CMP R7, R3
	BRnp L140_snake
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	JMP L141_snake
L140_snake
	LDR R7, R5, #-2
	CONST R3, #108
	CMP R7, R3
	BRnp L142_snake
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR turn_snake
	ADD R6, R6, #1	;; free space for arguments
	JMP L143_snake
L142_snake
	LDR R7, R5, #-2
	CONST R3, #113
	CMP R7, R3
	BRnp L144_snake
	JMP L132_snake
L144_snake
	LDR R7, R5, #-2
	CONST R3, #114
	CMP R7, R3
	BRnp L146_snake
	JSR play_game
	ADD R6, R6, #0	;; free space for arguments
	JMP L132_snake
L146_snake
L143_snake
L141_snake
L139_snake
L137_snake
	JSR update_game_state
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRnp L148_snake
	LEA R7, L150_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L132_snake
L148_snake
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRnp L151_snake
	LEA R7, L153_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L132_snake
L151_snake
L134_snake
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRz L133_snake
L132_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	LEA R7, L155_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L156_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L158_snake
L157_snake
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #113
	CMP R7, R3
	BRnp L160_snake
	JMP L159_snake
L160_snake
	LDR R7, R5, #-1
	CONST R3, #114
	CMP R7, R3
	BRnp L162_snake
	LEA R7, L164_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L165_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L166_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR play_game
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, L167_snake
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L162_snake
L158_snake
	JMP L157_snake
L159_snake
	CONST R7, #0
L154_snake
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
bombs_count 		.BLKW 1
		.DATA
fruit 		.BLKW 2
		.DATA
bomb 		.BLKW 10
		.DATA
snake_direction 		.BLKW 1
		.DATA
snake_length 		.BLKW 1
		.DATA
snake 		.BLKW 50
		.DATA
L167_snake 		.STRINGZ "Press 'r' to play again, or 'q' to quit...\n"
		.DATA
L166_snake 		.STRINGZ "Eat food (red) to grow, and avoid bombs (white)\n"
		.DATA
L165_snake 		.STRINGZ "Use i, j, k, l to move\n"
		.DATA
L164_snake 		.STRINGZ "\nNew game!\n"
		.DATA
L156_snake 		.STRINGZ "Press 'r' to start\n"
		.DATA
L155_snake 		.STRINGZ "Welcome to Snake!\n"
		.DATA
L153_snake 		.STRINGZ "Game lost.\n"
		.DATA
L150_snake 		.STRINGZ "Game won!\n"
		.DATA
L114_snake 		.STRINGZ "Bomb spawned\n"
		.DATA
L17_snake 		.STRINGZ "\n"
		.DATA
L10_snake 		.STRINGZ "-32768"
		.DATA
L4_snake 		.STRINGZ "0"
