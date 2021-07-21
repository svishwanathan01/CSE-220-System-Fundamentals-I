.data
pair: .word 12 8
terms: .word 0 3 2 2 5 0 0 -1
p: .word 0
N: .word 5
N1: .word 1

.text:
main:
    la $a0, p
    la $a1, pair
    jal init_polynomial

    la $a0, p
  #  sw $0, 0($a0)
    la $a1, terms
    lw $a2, N
    jal add_N_terms_to_polynomial

    la $a0, p
    lw $a1, N1
    jal remove_Nth_term

    #write test code
    
     move $a0, $v0
    li $v0, 1
    syscall
    
    li $a0, '\n'
    li $v0, 11
    syscall
    
    move $a0, $v1
    li $v0, 1
    syscall
    li $a0, '\n'
    li $v0,11
    syscall
    
printPoly:   
    		la $t0, p
    		lw $t1, 0($t0)
    		lw $a0, 0($t1)
    		li $v0, 1
    		syscall
    		lw $a0, 4($t1)
    		li $v0, 1
    		syscall
    		lw $a0, 8($t1)
    		beqz $a0, end
    		la $t0, p
    		lw $t2, 8($t1)
    		sw $t2, 0($t0)
    		j printPoly
    
    
    end:li $v0, 10
    	syscall

.include "hw5.asm"
