############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
.text:

str_len:
	addi $sp $sp, -8
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # string
	move $v0, $zero
	move $t1, $zero
	
	str_len_loop:
		lb $t0, 0($s0)
		beqz $t0, str_len_end
		addi $t1, $t1, 1
		addi $s0, $s0, 1
		j str_len_loop
	
	str_len_end:
		move $v0, $t1
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		jr $ra
		
str_equals:
	addi $sp $sp, -20
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	
	
	move $s0, $a0
	move $s1, $a1
	
	move $a0, $s0
	jal str_len
	move $s2, $v0 # length of str1
	
	move $a0, $s1
	jal str_len
	move $s3, $v0 # length of str2
	
	bne $s2, $s3, not_equal
	li $v0, 1
	li $t0, 0
	
	str_equals_loop:
		beq $t0, $s2, str_equals_end
		lb $t1, 0($s0)
		lb $t2, 0($s1)
		bne $t1, $t2, not_equal
		addi $s0, $s0, 1
		addi $s1, $s1, 1
		addi $t0, $t0, 1
		j str_equals_loop
		
	
	not_equal:
		li $v0, 0
	
	str_equals_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		addi $sp, $sp, 20
		
		jr $ra
		
str_cpy:
	addi $sp $sp, -8
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0
	move $s1, $a1
	
	move $a0, $s0
	jal str_len
	
	move $t1, $v0
	move $t2, $zero
	
	str_cpy_loop:
		beq $t1, $t2, str_cpy_end
		lb $t0, 0($s0)
		sb $t0, 0($s1)
		addi $s0, $s0, 1
		addi $s1, $s1, 1
		addi $t2, $t2, 1
		j str_cpy_loop
	
	str_cpy_end:
		li $t0, 0 # add 0 to end of string
		sb $t0, 0($s1)
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addi $sp, $sp, 8
		jr $ra

create_person:
	move $s0, $a0
	move $v0, $a0
	
	lw $t0, 0($s0) # max nodes
	addi $s0, $s0, 8
	lw $t3, 0($s0) # size of node
	addi $s0, $s0, 8
	lw $t1, 0($s0) # current num of nodes
	
	bltz $t1, no_free_nodes
	
	#addi $s0, $s0, 8
	
	
	bge $t1, $t0, no_free_nodes
	
	mult $t3, $t1
	mflo $t2 # total num of node bytes
	#li $t0, 60
	#bge $t2, $t0, no_free_nodes # if there are no nodes available, set as -1
	
	
	
	addi $t1, $t1, 1
	sw $t1, 0($s0)
	
	addi $v0, $v0, 36
	add $v0, $v0, $t2
	j create_person_end
	
	no_free_nodes:
		li $v0, -1
		j create_person_end
	
	create_person_end:
		jr $ra
		
is_person_exists:
	addi $sp $sp, -12
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)


	move $s0, $a0 # network
	move $s1, $a1 # person
	addi $s0, $s0, 8
	lw $s2, 0($s0) #size of node
	
	li $v0, 1
	
	sub $t0, $a1, $a0
	li $t1, 36
	sub $t0, $t0, $t1
	div $t0, $s2
	mflo $t0
	addi $t0, $t0, 1
	addi $s0, $s0, 8
	lw $t1, 0($s0)
	bgt $t0, $t1, does_not_exist
	
	#lb $t0, 0($s1)
	#beqz $t0, does_not_exist 
	j is_person_exists_end
	
	does_not_exist:
		li $v0, 0
		j is_person_exists_end	
	
	is_person_exists_end:	
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		addi $sp, $sp, 12
		jr $ra
		
is_person_name_exists:
	addi $sp $sp, -20
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	
	move $s0, $a0 # network
	move $s1, $a1 # name
	lw $s2, 16($s0) # num of nodes
	addi $s0, $s0, 8
	lw $s4, 0($s0) # max length of node
	# lw $s3, 0($s0) #size of node
	
	move $a0, $s1
	jal str_len
	move $s3, $v0 # length of string
	
	addi $s0, $s0, 28
	li $t0, 0 # byte of node counter
	li $t1, 0 # number of nodes counter
	li $v0, 0
	
	is_person_name_exists_loop:
		beq $t1, $s2, name_does_not_exist
		beq $t0, $s3, name_exists
		lb $t2, 0($s0)
		lb $t3, 0($s1)
		bne $t2, $t3, not_curr_add
	
		addi $t0, $t0, 1
		addi $s0, $s0, 1
		addi $s1, $s1, 1
		
		j is_person_name_exists_loop
	
	not_curr_add:
		addi $t1, $t1, 1
		add $s0, $s0, $s4
		sub $s0, $s0, $t0
		sub $s1, $s1, $t0
		#addi $s0, $s0, -1
		li $t0, 0
		
		j is_person_name_exists_loop
	
	name_exists:
		li $v0, 1
		sub $s0, $s0, $s3
		move $v1, $s0
		j is_person_name_exists_end
	
	name_does_not_exist:
		li $v0, 0
		j is_person_name_exists_end
	
	is_person_name_exists_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		addi $sp, $sp, 20
		
		jr $ra
		
add_person_property:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # network
	move $s1, $a1 # person
	move $s2, $a2 # prop_name
	move $s3, $a3 # prop_val
	li $v0, 1
	
	li $t0, 'N'
	lb $t1, 0($s2)
	bne $t0, $t1, cond_1_violated
	li $t0, 'A'
	lb $t1, 1($s2)
	bne $t0, $t1, cond_1_violated
	li $t0, 'M'
	lb $t1, 2($s2)
	bne $t0, $t1, cond_1_violated
	li $t0, 'E'
	lb $t1, 3($s2)
	bne $t0, $t1, cond_1_violated
	li $t0, 0
	lb $t1, 4($s2)
	bne $t0, $t1, cond_1_violated
	
	addi $s0, $s0, 16
	lw $t0, 0($s0) # current number of nodes
	beqz $t0, cond_2_violated
	
	addi $s0, $s0, -8
	lw $s4, 0($s0) # max size of node
	
	move $a0, $s3
	jal str_len
	bge $v0, $s4, cond_3_violated
	move $s5, $v0 # length of string
	li $v0, 1
	
	addi $s0, $s0, -8
	move $a0, $s0
	move $a1, $s3
	jal is_person_name_exists
	bnez $v0, cond_4_violated
	
	li $v0, 1
	
	li $t0, 0
	add_person_property_loop:
		beq $t0, $s5, add_null_char_app
		lb $t1, 0($s3)
		sb $t1, 0($s1)
		addi $s1, $s1, 1
		addi $s3, $s3, 1
		addi $t0, $t0, 1
		
		j add_person_property_loop
	
	add_null_char_app:
		li $t1, 0
		sb $t1, 0($s1)
		li $v0, 1
		j add_person_property_end
	
	cond_1_violated:
		li $v0, 0
		j add_person_property_end
	
	cond_2_violated:
		li $v0, -1
		j add_person_property_end
	
	cond_3_violated:
		li $v0, -2
		j add_person_property_end
	
	cond_4_violated:
		li $v0, -3
		j add_person_property_end
	
	add_person_property_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
get_person:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0
	move $s1, $a0
	
	jal is_person_name_exists
	
	beqz $v0, no_person_exists_gp
	move $v0, $v1
	j get_person_end
	
	no_person_exists_gp:
		li $v0, 0
		j get_person_end
	
	get_person_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
is_relation_exists:
	addi $sp $sp, -20
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)

	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	lw $s3, 20($s0)
	beqz $s3, no_relation_exists
	
	# total number of nodes, size of each node, multiply those, add that to network +36
	lw $t0, 0($s0)
	lw $t1, 8($s0)
	mult $t0, $t1
	mflo $t0
	
	li $t1, 4
	div $t0, $t1
	mfhi $t2
	beqz $t2, relation_setup
	mflo $t3
	sub $t1, $t1, $t2
	add $t0, $t0, $t1
	
	j relation_setup
	
	relation_setup:
		addi $s0, $s0, 36
		add $s0, $s0, $t0
		li $v0, 0
		li $t2, 0 # edges counter
	
	is_relation_exists_loop:
		beq $s3, $t2, no_relation_exists
		lw $t0, 0($s0) # first word in relationship
		lw $t1, 4($s0)
		beq $t0, $s1, check_1_2
		beq $t0, $s2, check_1_1
		
		addi $s0, $s0, 12
		addi $t2, $t2, 1
		j is_relation_exists_loop
		
	check_1_2:
		beq $t1, $s2, relation_exists
		addi $s0, $s0, 12
		addi $t2, $t2, 1
		j is_relation_exists_loop
		
	check_1_1:
		beq $t1, $s1, relation_exists
		addi $s0, $s0, 12
		addi $t2, $t2, 1
		j is_relation_exists_loop
		
	no_relation_exists:
		li $v0, 0
		j is_relation_exists_end
	
	relation_exists:
		li $v0, 1
		move $t9, $s0 # get the prop_value of address
		
		j is_relation_exists_end
	
	is_relation_exists_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		addi $sp, $sp, 20
		jr $ra
		
add_relation:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # network
	move $s1, $a1 # person1
	move $s2, $a2 # person2
	
	move $a0, $s0
	move $a1, $s1
	jal is_person_exists
	beqz $v0, cond_1_ar
	
	move $a0, $s0
	move $a1, $s2
	jal is_person_exists
	beqz $v0, cond_1_ar
	
	addi $s0, $s0, 4
	lw $t0, 0($s0)
	addi $s0, $s0, 16
	lw $t1, 0($s0)
	bge $t1, $t0, cond_2_ar
	bltz $t1, cond_2_ar
	addi $s0, $s0, -20
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal is_relation_exists
	bnez $v0, cond_3_ar
	
	move $a0, $s1
	move $a1, $s2
	jal str_equals
	bnez $v0, cond_4_ar
	
	li $v0, 1
	addi $s0, $s0, 20
	lw $s3, 0($s0) # number of edges
	addi $s3, $s3, 1
	sb $s3, 0($s0)
	addi $s3, $s3, -1
	addi $s0, $s0, -20
	
	# total number of nodes, size of each node, multiply those, add that to network +36
	lw $t0, 0($s0)
	lw $t1, 8($s0)
	mult $t0, $t1
	mflo $t0
	
	li $t1, 4
	div $t0, $t1
	mfhi $t2
	beqz $t2, add_relation_setup
	mflo $t3
	sub $t1, $t1, $t2
	add $t0, $t0, $t1
	
	j add_relation_setup
	
	add_relation_setup:
		addi $s0, $s0, 36
		add $s0, $s0, $t0
		li $t1, 12
		mult $t1, $s3
		mflo $t1 # total number of bytes
		add $s0, $s0, $t1
		sw $s1, 0($s0)
		sw $s2, 4($s0)
	
	j add_relation_end
	
	
	cond_1_ar:
		li $v0, 0
		j add_relation_end
	
	cond_2_ar:
		li $v0, -1
		j add_relation_end
	
	cond_3_ar:
		li $v0, -2
		j add_relation_end	
	
	cond_4_ar:
		li $v0, -3
		j add_relation_end	
	
	
	
	add_relation_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
add_relation_property:
	move $s0, $a0 # network 
	move $s1, $a1 # person 1
	move $s2, $a2 # person 2
	move $s3, $a3 # prop_name
	lw $s4, 0($sp) # prop_val
	addi $sp, $sp, 4
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal is_relation_exists
	beqz $v0, cond_1_arp
	
	li $t0, 'F'
	lb $t1, 0($s3)
	bne $t0, $t1, cond_2_arp
	li $t0, 'R'
	lb $t1, 1($s3)
	bne $t0, $t1, cond_2_arp
	li $t0, 'I'
	lb $t1, 2($s3)
	bne $t0, $t1, cond_2_arp
	li $t0, 'E'
	lb $t1, 3($s3)
	bne $t0, $t1, cond_2_arp
	li $t0, 'N'
	lb $t1, 4($s3)
	bne $t0, $t1, cond_2_arp
	li $t0, 'D'
	lb $t1, 5($s3)
	bne $t0, $t1, cond_2_arp
	li $t0, 0
	lb $t1, 6($s3)
	bne $t0, $t1, cond_2_arp
	
	bltz $s4, cond_3_arp
	
	addi $t9, $t9, 8
	sw $s4, 0($t9)
	
	li $v0, 1
	
	j add_relation_property_end
	
	cond_1_arp:
		li $v0, 0
		j add_relation_property_end
	
	cond_2_arp:
		li $v0, -1
		j add_relation_property_end
	
	cond_3_arp:
		li $v0, -2
		j add_relation_property_end
	
	add_relation_property_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
is_friend_of_friend:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	move $a0, $s0
	move $a1, $s1
	jal is_person_name_exists
	beqz $v0, no_person_ifof
	move $s1, $v1 # address of first person
	
	move $a0, $s0
	move $a1, $s2
	jal is_person_name_exists
	beqz $v0, no_person_ifof
	move $s2, $v1 # address of second person
	
	move $a0, $s1
	move $a1, $s2
	jal str_equals
	bnez $v0, not_friend_of_friend
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal is_relation_exists
	bnez $v0, not_friend_of_friend
	
	move $s5, $s0 # network used to iterate through
	addi $s5, $s5, 8
	lw $s3, 0($s5) # size of node
	addi $s5, $s5, 8
	lw $s4, 0($s5) # total number of nodes
	li $s6, 0 # node counter
	addi $s5, $s5, 20
	
	is_friend_of_friend_loop:
		beq $s6, $s4, not_friend_of_friend
		move $s7, $s0 # str copy
		addi $s7, $s7, 216
		
		move $a0, $s5
		move $a1, $s7
		jal str_cpy
		
		move $a0, $s1
		move $a1, $s7
		jal str_equals
		bnez $v0, next_node # if it is the same node
		
		#move $a0, $s2
		#move $a1, $s7
		#jal str_equals
		#bnez $v0, next_node # if it is the same node
		
		move $a0, $s0
		move $a1, $s1
		move $a2, $s5
		jal is_relation_exists
		beqz $v0, next_node
		bltz $t9, next_node
		
		move $a0, $s0
		move $a1, $s2
		move $a2, $s5
		jal is_relation_exists
		beqz $v0, next_node
		bltz $t9, next_node
		
		j ifof_true
	
	next_node:
		add $s5, $s5, $s3
		addi $s6, $s6, 1
		j is_friend_of_friend_loop
	
	no_person_ifof:	
		li $v0, -1
		j is_friend_of_friend_end
	
	not_friend_of_friend:
		li $v0, 0
		j is_friend_of_friend_end
	
	ifof_true:
		li $v0, 1
		j is_friend_of_friend_end
	
	is_friend_of_friend_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
