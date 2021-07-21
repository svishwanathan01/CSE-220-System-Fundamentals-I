.data
int_array: .word 3 3 1 2 1 0 6 -1

.text:
main:
	la $a0, int_array
    jal remove_from_array
	
	move $a0, $v0
	li $v0, 1
	syscall

    li $v0, 10
    syscall

.include "hw5.asm"
