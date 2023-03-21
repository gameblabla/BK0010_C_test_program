# optimized LZSA3 decompressor for PDP-11 by Manwe and Ivanq
# Thanks to Ivan Gorodetsky
# Usage:
# MOV #src_adr,R1
# MOV #dst_adr,R2
# CALL _Unpacklzsa3

.extern _Unpacklzsa3
.globl _Unpacklzsa3

_Unpacklzsa3:
		CLR R4				# Also needed for GAS version otherwise crash
		CLR R5				# no nibbles sign
Token:	MOVB (R1)+,R3		# read token

Liter:	MOV R3,R0
		BIC $0177774,R0		# get 2 bits
		BEQ Decode
		CMP R0,$03			# literals length
		BNE Copy
			jsr pc, Extend
Copy:	MOVB (R1)+,(R2)+	# literals length in R0
		SOB R0,Copy

Decode:	MOV R3,-(SP)
		ROLB R3				# get 2 bits
		ROL R0
		ROLB R3
		ROL R0
		ASL R0
		ADD R0,PC			# run subroutine
		BR oOther
		BR o9bit
		BR o13bit

o5bit:  jsr pc, Nibble			# get nibble in R0
		ROLB R3
		ROL R0
		INC R0

Save:	MOV R0,R4			# save offset for future

Match:	MOV (SP)+,R0
		ASR R0
		ASR R0
		BIC $0177770,R0		# get 3 bits
		CMP R0,$07
		BNE Clone
			jsr pc, Extend
			TSTB R0			# match length
			BEQ Exit

Clone:	MOV R2,R3
		SUB R4,R3
		MOVB (R3)+,(R2)+
		INC R0
loop_clone:		MOVB (R3)+,(R2)+
		SOB R0,loop_clone
		BR Token

o9bit:	CLR R0
		BISB (R1)+,R0
		ROLB R3
		ROL R0
		INC R0
		BR Save

o13bit:	jsr pc, Nibble 		# get nibble in R0
		ROLB R3
		ROL R0
		SWAB R0
		BISB (R1)+,R0		# 8 bits
		ADD $513,R0
		BR Save

oOther:	ROLB R3
		BCS Match
		BISB (R1)+,R0		# read 16 bits
		SWAB R0
		BISB (R1)+,R0
		BR Save


Nibble:	COM R5
		BMI myloop1_nibble
			MOV R5,R0
			CLR R5
			BR myloop2_nibble
myloop1_nibble:		BICB (R1)+,R5		# read 2 nibbles
		MOV R5,R0
		ASR R0
		ASR R0
		ASR R0
		ASR R0
myloop2_nibble:		BIC $0177760,R0		# leave 4 low bits
		RTS PC

Extend:	MOV R0,-(SP)		# save original value
		jsr pc, Nibble 		# get nibble in R0
		BNE Ext2
			BISB (R1)+,R0
			BNE Ext1
				# unnecessary for short files
				BISB (R1)+,R0	# read high byte
				SWAB R0
				BISB (R1)+,R0	# read low byte
				TST (SP)+		# skip saved R0
				RTS PC
Ext1:		ADD $15,R0
Ext2:	DEC R0
		ADD (SP)+,R0		# add original value
Exit:	RTS PC
