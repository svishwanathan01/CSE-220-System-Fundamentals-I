############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
.text:

create_term:
	addi $sp $sp, -12
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # coeff
	move $s1, $a1 # exp
	
	li $a0, 12
	li $v0, 9
	syscall
	
	move $s2, $v0 # memory address
	beqz $s0, create_term_error
	bltz $s1, create_term_error
	
	sw $s0, 0($v0)
	sw $s1, 4($v0)
	li $t0, 0
	sw $t0, 8($v0)
	j create_term_end	
	
	create_term_error:
		li $v0, -1
		j create_term_end

	create_term_end:	
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		addi $sp, $sp, 12
		
		jr $ra
	
init_polynomial:
	addi $sp $sp, -12
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # Polynomial pointer
	move $s1, $a1 # pair
	lw $t0, 0($s1) # Coefficient
	lw $t1, 4($s1) # Exponent
	move $a0, $t0
	move $a1, $t1
	jal create_term
	bltz $v0, init_polynomial_end
	
	sw $v0, 0($s0)
	li $v0, 1
	j init_polynomial_end
	
	init_polynomial_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		addi $sp, $sp, 12
		jr $ra
	
add_N_terms_to_polynomial:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # Polynomial pointer
	move $s1, $a1 # Terms
	move $s2, $a2 # No. of terms to be added
	li $s3, 0 # Terms added counter
	li $s5, 0 # Terms considered
	bgtz $s2, add_terms_loop
	li $v0, 0
	j add_terms_end
	
	add_terms_loop:
		beq $s2, $s5, add_terms_end # if we have considered the max # of terms
		lw $s4, 0($s0) # head address
		lw $t0, 0($s1) # term coeff
		lw $t1, 4($s1) # term exp
		lw $t6, 0($s4) # head coeff
		lw $t2, 4($s4) # head exp
		move $t3, $s4
		beqz $t0, check_end
		beq $t1, $t2, next_term # if there is a term already at that degree, skip
		bgt $t1, $t2, add_term_to_head
		j term_not_at_head
		
	check_end:
		li $t9, -1
		beq $t9, $t1, add_terms_end
		beq $t1, $t2, next_term # if there is a term already at that degree, skip
		bgt $t1, $t2, add_term_to_head
		j term_not_at_head
	
	add_term_to_head:
		move $a0, $t0
		move $a1, $t1
		jal create_term
		bltz $v0, next_term
		move $t0, $v0
		sw $s4, 8($t0) # add the old head as the next term of the new head
		sw $t0, 0($s0) # add the new head to the polynomial pointer
		
		addi $s3, $s3, 1 # increment, term added
		j next_term
	
	next_term:
		addi $s5, $s5, 1
		addi $s1, $s1, 8
		j add_terms_loop
		
	
	term_not_at_head:
		move $t8, $t3 # move previous address to this temp register
		lw $t3, 8($s4) # next term address
		beqz $t3, term_less_than
		lw $t6, 0($t3) # head coeff
		lw $t2, 4($t3) # heap term exp
		beq $t1, $t2, next_term # if there is a term already at that degree, skip
		bgt $t1, $t2, add_term_heap
		lw $s4, 8($s4)
		j term_not_at_head
	
	add_term_heap:
		move $a0, $t0
		move $a1, $t1
		jal create_term
		bltz $v0, next_term
		beqz $t8, add_heaps_memory
		sw $v0, 8($t8)
		move $t0, $v0
		sw $t3, 8($t0)  # add the old heap term as the next term of the new heap term

		addi $s3, $s3, 1  # increment, term added
		j next_term
	
	add_heaps_memory:
		lw $t8, 0($s0)
		sw $v0, 8($t8)
		move $t0, $v0
		sw $t3, 8($t0)  # add the old heap term as the next term of the new heap term

		addi $s3, $s3, 1  # increment, term added
		j next_term

	
	#term_less_than:	
	term_less_than:
		move $a0, $t0  # when the term we are putting in is less than; i.e. when we reach the last term
		move $a1, $t1
		jal create_term  # have to also set previous term's next term as this term created
		bltz $v0, next_term
		beqz $t3, add_next_to_head
		lw $t5, 8($t3)
		#beqz $t5, add_next_to_prev
		sw $v0, 8($t5)
		#sw $t5, 8($v0)
		#sw $v0, 8($t3)

		addi $s3, $s3, 1  # increment, term added
		j next_term
	
	add_next_to_head:
		sw $v0, 8($s4)
		addi $s3, $s3, 1  # increment, term added
		j next_term

#add_next_to_prev:
#sw $v0, 8($t3)
#addi $s3, $s3, 1  # increment, term added
#j
#next_term
	
	add_terms_end:
		move $v0, $s3
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		
		addi $sp, $sp, 28
		
		jr $ra
	
update_N_terms_in_polynomial:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # Polynomial pointer
	move $s1, $a1 # Terms
	move $s2, $a2 # No. of terms to be added
	move $s6, $a0
	addi $s6, $s6, 10000 # array of exponent values
	li $t0, -1
	sw $t0, 0($s6)
	
	li $s3, 0 # Terms added counter
	li $s5, 0 # Terms considered
	
	bgtz $s2, update_terms_loop
	li $v0, 0
	j update_terms_end
	
	update_terms_loop:
		beq $s2, $s5, update_terms_end
		lw $s4, 0($s0) # head address
		beqz $s4, no_terms_updated
		lw $t0, 0($s1) # term coeff
		lw $t1, 4($s1) # term exp
		lw $t2, 4($s4) # head exp
		beqz $t0, check_end_ut
		bne $t1, $t2, next_address_update # if the term isn't at the head
		sw $t0, 0($s4)
		
		move $a0, $s6 # array of terms
		move $a1, $t1 # term exponent
		jal exists_in_array
		bnez $v0, next_term_ut # if the term exists, skip incrementing to the total number of terms changed
		move $a0, $s6 # array of terms
		move $a1, $t1 # term exponent
		jal add_to_array
		
		addi $s3, $s3, 1
		j next_term_ut
	
	check_end_ut:
		li $t9, -1
		beq $t1, $t9, update_terms_end
		j next_term_ut	
		
	next_address_update:
		beq $t1, $t2, update_term # if there is a term at the given exponent, update the term
		# else give reference to the next address in linked list
		lw $t3, 8($s4)
		move $s4, $t3
		beqz $t3, next_term_ut
		lw $t2, 4($t3)
		j next_address_update
			
	update_term:
		sw $t0, 0($t3)
		move $a0, $s6 # array of terms
		move $a1, $t1 # term exponent
		jal exists_in_array
		bnez $v0, next_term_ut # if the term exists, skip incrementing to the total number of terms changed
		move $a0, $s6 # array of terms
		move $a1, $t1 # term exponent
		jal add_to_array
		
		addi $s3, $s3, 1
		j next_term_ut
	
	next_term_ut:
		addi $s1, $s1, 8
		addi $s5 $s5, 1
		j update_terms_loop
	
	no_terms_updated:
		li $v0, 0
		j update_terms_end
	
	update_terms_end:
		move $a0, $s6
		jal remove_from_array
		
		move $v0, $s3
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		
		addi $sp, $sp, 28
		
		jr $ra
	
get_Nth_term:
	addi $sp $sp, -12
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # Polynomial head
	move $s1, $a1 # N'th term
	beqz $s1, not_found_get
	li $s2, 1
	lw $t9, 0($s0)
	move $s0, $t9
	
	get_term_loop:
		beq $s2, $s1, found_get
		lw $t9, 8($s0)
		beqz $t9, not_found_get
		move $s0, $t9
		addi $s2, $s2, 1
		j get_term_loop
	
	found_get:
		lw $v1, 0($s0)
		lw $v0, 4($s0)
		j get_Nth_term_end
			
	not_found_get:
		li $v0, -1
		li $v1, 0
		j get_Nth_term_end
	
	get_Nth_term_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		
		addi $sp, $sp, 12
		
		jr $ra
	
remove_Nth_term:
	addi $sp $sp, -12
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # Polynomial head
	move $s1, $a1 # N'th term
	beqz $s1, not_found_remove
	li $s2, 1
	lw $t9, 0($s0)
	move $s0, $t9
	beq $s1, $s2, remove_from_head
	
	remove_term_loop:
		beq $s2, $s1, found_remove
		lw $t9, 8($s0)
		move $t8, $s0 # old address
		beqz $t9, not_found_remove
		move $s0, $t9
		addi $s2, $s2, 1
		j remove_term_loop
	
	found_remove:
		lw $v1, 0($s0)
		lw $v0, 4($s0)
		li $t9, 0
		sw $t9, 0($s0)
		sw $t9, 4($s0)
		lw $t9, 8($s0)
		sw $t9, 8($t8) # move address
		li $t9, 0
		sw $t9, 8($s0)
		j remove_Nth_term_end
	
	remove_from_head:
		lw $t8, 0($a0) # get the head address
		beqz $t8, not_found_remove
		li $t9, 0
		lw $v1, 0($t8)
		lw $v0, 4($t8)
		sw $t9, 0($t8) # make coeff 0
		sw $t9, 4($t8) # make exp 0
		lw $t9, 8($t8) # get next term
		sw $t9, 0($a0) # make next term the head
		li $t9, 0
		sw $t9, 8($t8) # make address 0
		j remove_Nth_term_end
		
	
	not_found_remove:
		li $v0, -1
		li $v1, 0
		j remove_Nth_term_end
	
	remove_Nth_term_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		
		addi $sp, $sp, 12
		jr $ra
	
add_poly:
	addi $sp $sp, -28
	#sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # Polynomial p
	move $s1, $a1 # Polynomial q
	move $s2, $a2 # Polynomial r
	
	lw $s3, 0($s0) # p address
	lw $s4, 0($s1) # q address
	lw $s5, 0($s2) # r address
	li $s6, 0 # term counter
	
	
	add_poly_start:
	beqz $s3, q_identity
	beqz $s4, p_identity
	
	lw $t0, 4($s3)
	lw $t1, 4($s4)
	bge $t0, $t1, add_p_head # if the p[head, exp] >= q[head, exp], add p[head] to r[head]
	move $a0, $s2 # else add q[head] to r[head]
	move $a1, $s4
	jal init_polynomial
	lw $s4, 8($s4)
	addi $s6, $s6, 1
	j add_loop
	
	p_identity:
		beqz $s3, add_done
		move $a0, $s2
		move $a1, $s3
		jal init_polynomial
		lw $s3, 8($s3)
		addi $s6, $s6, 1
		
		p_identity_loop:
			beqz $s3, add_done
			move $a0, $s2
			move $a1, $s3
			li $a2, 1
			jal add_N_terms_to_polynomial
			lw $s3, 8($s3)
			addi $s6, $s6, 1
			j p_identity_loop
		
	q_identity:
		beqz $s4, add_done
		move $a0, $s2
		move $a1, $s4
		jal init_polynomial
		lw $s4, 8($s4)
		addi $s6, $s6, 1
		q_identity_loop:
			beqz $s4, add_done
			move $a0, $s2
			move $a1, $s4
			li $a2, 1
			jal add_N_terms_to_polynomial
			lw $s4, 8($s4)
			addi $s6, $s6, 1
			j q_identity_loop
	
	add_p_head:
		move $a0, $s2
		move $a1, $s3
		jal init_polynomial
		lw $s3, 8($s3)
		addi $s6, $s6, 1
		j add_loop
		
	add_loop:
		beqz $s3, add_rest_of_q
		beqz $s4, add_rest_of_p
		lw $t0, 4($s3)
		lw $t1, 4($s4)
		bge $t0, $t1, add_rest_of_p
		j add_rest_of_q
	
#	add_p_term:#
#		move $a0, $s2
#		move $a1, $s3
#		li $a2, 1
#		jal add_N_terms_to_polynomial
#		beqz $v0, update_instead_p
#		lw $s3, 8($s3)
#		j add_loop
	
	add_rest_of_p:
		beqz $s3, add_done
		move $a0, $s2
		move $a1, $s3
		li $a2, 1
		jal add_N_terms_to_polynomial
		beqz $v0, update_instead_p
		addi $s6, $s6, 1
		lw $s3, 8($s3)
		j add_loop
		
	update_instead_p:
		move $t0, $zero
		add $t0, $t0, $t6
		move $t1, $zero
		lw $t1, 0($s3)
		add $t0, $t0, $t1  # t0 = t6 + t1
		move $t6, $zero
		sw $t0, 0($t6)
		lw $t0, 4($s3)
		sw $t0, 4($t6)
		
		move $a0, $s2
		move $a1, $t6
		li $a2, 1
		jal update_N_terms_in_polynomial
		lw $s3, 8($s3)
		j add_loop
	
	add_rest_of_q:
		beqz $s4, add_done
		move $a0, $s2
		move $a1, $s4
		li $a2, 1
		jal add_N_terms_to_polynomial
		beqz $v0, update_instead_q
		addi $s6, $s6, 1
		lw $s4, 8($s4)
		j add_loop
		
	update_instead_q:
		move $t0, $zero
		add $t0, $t0, $t6
		move $t1, $zero
		lw $t1, 0($s4)
		add $t0, $t0, $t1  # t0 = t6 + t1
		#move $t6, $zero
		#addi $t6, $t6, 5000
		#sw $t0, 0($t6)
		#lw $t0, 4($s4)
		#sw $t0, 4($t6)
		beqz $t0, update_zero_case
		move $a1, $s4
		addi $a1, $a1, 10000
		sw $t0, 0($a1)
		lw $t0, 4($s4)
		sw $t0, 4($a1)
		move $a0, $s2
		#move $a1, $t6
		li $a2, 1
		jal update_N_terms_in_polynomial
		move $a1, $s4
		addi $a1, $a1, 10000
		li $t0, 0
		sw $t0, 0($a1)
		sw $t0, 4($a1)
		lw $s4, 8($s4)
		j add_loop
	
	update_zero_case:
		move $a0, $s2
		move $a1, $s6
		jal remove_Nth_term
		lw $s4, 8($s4)
		addi $s6, $s6, -1
		beqz $s6, add_poly_start
		j add_loop
			
	add_done:
		beqz $s6, none_added
		#lw $t0, 
		li $v0, 1
		j add_poly_end
	
	none_added:
		li $v0, 0
		j add_poly_end
	
	add_poly_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		#lw $s7, 28($sp)
		
		addi $sp, $sp, 28
		
		jr $ra
	
mult_poly:
	addi $sp $sp, -32
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # Polynomial p
	move $s1, $a1 # Polynomial q
	move $s2, $a2 # Polynomial r
	
	
	lw $s3, 0($s0) # p address
	lw $s4, 0($s1) # q address
	lw $s5, 0($s2) # r address
	
	beqz $s3, q_identity_mult
	beqz $s4, p_identity_mult
	
	move $s6, $s3
	addi $s6, $s6, 10000
	move $s7, $zero
	
	lw $t0, 0($s3) # p coeff
	lw $t1, 4($s3) # p exp
	lw $t2, 0($s4) # q coeff
	lw $t3, 4($s4) # q exp
	mult $t0, $t2
	mflo $t0 # coeff to add
	add $t1, $t1, $t3 # exp to add
	sw $t0, 0($s6)
	sw $t1, 4($s6)
	move $a0, $s2
	move $a1, $s6
	jal init_polynomial
	lw $s4, 8($s4)
	addi $s7, $s7, 1
	
	j mult_poly_loop
	
	p_identity_mult:
		beqz $s3, mult_done
		move $a0, $s2
		move $a1, $s3
		jal init_polynomial
		lw $s3, 8($s3)
		addi $s7, $s7, 1
		
		p_identity_mult_loop:
			beqz $s3, mult_done
			move $a0, $s2
			move $a1, $s3
			li $a2, 1
			jal add_N_terms_to_polynomial
			lw $s3, 8($s3)
			addi $s7, $s7, 1
			j p_identity_mult_loop
		
	q_identity_mult:
		beqz $s4, mult_done
		move $a0, $s2
		move $a1, $s4
		jal init_polynomial
		lw $s4, 8($s4)
		addi $s7, $s7, 1
		q_identity_mult_loop:
			beqz $s4, mult_done
			move $a0, $s2
			move $a1, $s4
			li $a2, 1
			jal add_N_terms_to_polynomial
			lw $s4, 8($s4)
			addi $s7, $s7, 1
			j q_identity_mult_loop
		
	
	mult_poly_loop:
		beqz $s4, next_p_term
		beqz $s3, mult_done
		
		lw $t0, 0($s3) # p coeff
		lw $t1, 4($s3) # p exp
		lw $t2, 0($s4) # q coeff
		lw $t3, 4($s4) # q exp
		mult $t0, $t2
		mflo $t0 # coeff to add
		add $t1, $t1, $t3 # exp to add
		sw $t0, 0($s6)
		sw $t1, 4($s6)
		move $a0, $s2
		move $a1, $s6
		li $a2, 1
		jal add_N_terms_to_polynomial
		beqz $v0, update_mult_terms
		addi $s7, $s7, 1
		li $t0, 0
		sw $t0, 0($s6)
		sw $t0, 4($s6)
		
		lw $s4, 8($s4)
		j mult_poly_loop
		
	update_mult_terms:
		add $t0, $t0, $t6
		beqz $t0, remove_instead_update
		
		sw $t0, 0($s6)
		sw $t1, 4($s6)
		move $a0, $s2
		move $a1, $s6
		li $a2, 1
		jal update_N_terms_in_polynomial
		li $t0, 0
		sw $t0, 0($s6)
		sw $t0, 4($s6)
		
		lw $s4, 8($s4)
		j mult_poly_loop
	
	remove_instead_update:
		move $a0, $s2
		move $a1, $s7
		jal remove_Nth_term
		addi $s7, $s7, -1
		lw $s4, 8($s4)
		j mult_poly_loop
		
		
	
	next_p_term:
		lw $s4, 0($s1)
		lw $s3, 8($s3)
		j mult_poly_loop
	
	mult_done:
		beqz $s7, none_mult
		li $v0, 1
		j mult_poly_end
	
	none_mult:
		li $v0, 0
		j mult_poly_end
	
	mult_poly_end:
		#move $v0, $s7
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		
		addi $sp, $sp, 32
		
		jr $ra
	
	
	
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
# helper methods
exists_in_array:
	addi $sp $sp, -32
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # int array
	move $s1, $a1 # value to check if exists
	exists_loop:
		lw $t9, 0($s0)
		bltz $t9, does_not_exist
		beq $s1, $t9, val_exists
		addi $s0, $s0, 4
		j exists_loop
		
	val_exists:
		li $v0, 1
		j exists_end
		
	does_not_exist:
		li $v0, 0
		j exists_end
		
	exists_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		
		addi $sp, $sp, 32
		
		jr $ra

add_to_array:
	addi $sp $sp, -32
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # int array
	move $s1, $a1 # value to add
	li $t9, -1
	
	add_to_array_loop:
		lw $t8, 0($s0)
		beq $t8, $t9, add_val
		addi $s0, $s0, 4
		j add_to_array_loop
	
	add_val:
		sw $s1, 0($s0)
		sw $t9, 4($s0)
	
	add_to_array_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		
		addi $sp, $sp, 32
		
		jr $ra

remove_from_array:
	addi $sp $sp, -32
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # int array
	
	remove_loop:
		li $t9, -1
		lw $t8, 0($s0)
		beq $t9, $t8, remove_from_array_end
		li $t9, 0
		sw $t9, 0($s0)
		addi $s0, $s0, 4
		j remove_loop

	remove_from_array_end:
		li $t9, 0
		sw $t9, 0($s0)
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		lw $s7, 28($sp)
		
		addi $sp, $sp, 32
		
		jr $ra
	
		
