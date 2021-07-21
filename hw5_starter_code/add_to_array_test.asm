.data
int_array: .word 3 3 1 2 1 0 5 -1
value: .word 6

.text:
main:
	la $a0, int_array
    lw $a1, value
    jal add_to_array
	
	move $a0, $v0
	li $v0, 1
	syscall

    li $v0, 10
    syscall

.include "hw5.asm"