.data
pair: .word 1 1
terms: .word 2 2 3 3 4 4 0 -1
new_terms: .word 1 4 2 3 3 2 4 1 2 2 3 3 4 4 0 1 0 -1
p: .word 0
N: .word 20

.text:
main:
    
    li $s0, 9
    li $s1,8
    li $s2, 7
    li $s3,6
    li $s4, 5
    li $s5,4
    li $s6, 3
    li $s7,2
    
    la $a0, p
    la $a1, pair
    jal init_polynomial

    la $a0, p
    la $a1, terms
    lw $a2, N
    jal add_N_terms_to_polynomial

    la $a0, p
    la $a1, new_terms
    lw $a2, N
    jal update_N_terms_in_polynomial


    move $a0, $v0
    li $v0, 1
    syscall
    
    li $a0, '\n'
    li $v0,11
    syscall
    
    move $a0, $s0
    li $v0, 1
    syscall
    
     move $a0, $s1
    li $v0, 1
    syscall
    
     move $a0, $s2
    li $v0, 1
    syscall
    
     move $a0, $s3
    li $v0, 1
    syscall
    
     move $a0, $s4
    li $v0, 1
    syscall
    
     move $a0, $s5
    li $v0, 1
    syscall
    
     move $a0, $s6
    li $v0, 1
    syscall
    
    move $a0, $s7
    li $v0, 1
    syscall
    
    li $a0, '\n'
    li $v0,11
    syscall
    #j end
    #write test code
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
