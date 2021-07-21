.data
pair: .word 5 5
terms: .word 2 7 3 4 5 4 1 2 12 9 0 -1
p: .word 0
N: .word 5

.text:
main:
    la $a0, p
    la $a1, pair
    jal init_polynomial

    la $a0, p
    la $a1, terms
    lw $a2, N
    jal add_N_terms_to_polynomial

    #write test code

	move $a0, $v0
	li $v0, 1
	syscall
	
    li $v0, 10
    syscall

.include "hw5.asm"
