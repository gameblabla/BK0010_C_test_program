    	.text
    	.even
    	.globl	_main
    	.globl	___main
    	.globl	_start

#############################################################################*
##### _start: initialize stack pointer,
#####         clear vector memory area,
#####         save program entry in vector 0
#####         call C main() function
#############################################################################*
_start:
	mov	$037776,sp      # Set the stack pointer to a safe location in User RAM
	mov	$000137,*$0     # Store JMP _start in vector 0
	mov	$_start,*$2
	jsr 	pc,_main
	halt
	br	_start

#############################################################################*
##### ___main: called by C main() function. Currently does nothing
#############################################################################*
___main:
	rts	pc
