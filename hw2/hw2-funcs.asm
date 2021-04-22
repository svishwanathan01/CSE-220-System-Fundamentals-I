############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

############################## Do not .include any files! #############################

.text
eval:	
	addi $sp, $sp, -4
	sb $ra, 0($sp)
	
	li $s0, 0 #tp val_stack
	la $s1, val_stack #val_stack
	li $s2, 0 #tp op_stack
	la $s3, op_stack #op_stack
	addi $s3, $s3, 2000 #offset for op_stack
	move $s4, $a0
	
	li $t8, 2000
	bge $s0, $t8, errMsg
	bge $s2, $t8, errMsg
	
	move $t9, $zero
	beq $s2, $t9, checkPara
	

	checkPara:
		lbu $t0, 0($s4)
		li $t8, ')'
		beq $t0, $t8, illForm
	
	evalFunction:
	move $t0, $zero
	move $t1, $zero
	move $t2, $zero
	move $t3, $zero
	move $t4, $zero
	move $t5, $zero
	move $t6, $zero
	move $t7, $zero
	move $t8, $zero
	move $t9, $zero
	lbu $t0, 0($s4)
	
	 
	#if char == '(':
	li $t1, '('
	beq $t0, $t1, openPar #if is parentheses, push to op
	
	#elif char.isdigit():
	#move $t2, $a0 #save the string
	move $a0, $t0 #a0 register for is_digit
	jal is_digit
	move $t3, $a0 #save result of is_digit in t3
	#move $a0, $t2 #save a0 as the original string
	bnez $t3, digit #append digit if char is a digit
	
	#elif char == ')':
	li $t1, ')'
	beq $t0, $t1, closePar #if is parentheses, push to op
	
	#elif char.isoperator():
	#move $t2, $a0 #save the string
	isOperator: 
	beq $s0, $zero, illForm
	lbu $t0, 0($s4)
	move $a0, $t0
	jal valid_ops
	beqz $v0, errMsg
	
	#move $t2, $a0 #save the string
	move $a0, $s2
	addi $a0, $a0, -4
	jal is_stack_empty
	
	move $t3, $v0 #save result of is_stack_empty in t3
	#move $a0, $t2 #save a0 as the original string
	bnez $t3, pushCurrent
	
	#move $t2, $a0 #save the string
	
	#move $a0, $s2 #tp 
	#move $a1, $s3 #peek op stack
	
	
	
	lbu $t0, 0($s4)
	
	
	move $a0, $t0
	jal op_precedence
	move $t7, $v0 #precedence(tokens[i])
	
	#move $t2, $a0 #save the string
	move $a0, $s2
	move $a1, $s3
	addi $a0, $a0, -4
	jal stack_peek
	
	move $a0, $v0 #ops[-1]
	li $t6, '('
	beq $t6, $a0, pushCurrent
	jal op_precedence
	move $t6, $v0 #precendence(ops[-1]
	#move $a0, $t2
	
	blt $t6, $t7, pushCurrent
	
	#else
	addi $s0, $s0, -4
	move $a0, $s0 #tp val
	move $a1, $s1 #base addr val
	jal stack_pop
	move $t7, $v1 #val2
	
	addi $s0, $s0, -4
	move $a0, $s0 #tp val
	move $a1, $s1 #base addr val
	jal stack_pop
	move $t5, $v1 #val1
	
	addi $s2, $s2, -4
	move $a0, $s2 #tp op
	move $a1, $s3 #base addr op
	jal stack_pop
	move $t6, $v1 #op
	
	#apply bin op
	move $a0, $t5
	move $a1, $t6
	move $a2, $t7
	jal apply_bop
		
	move $a0, $v0
	move $a1, $s0
	move $a2, $s1
	jal stack_push
	move $s0, $v0	
	
	j isOperator
	
	
	errMsg:
		li $v0, 4
		la $a0, BadToken
		syscall
		li $v0, 10
		syscall
	
	illForm:
		li $v0, 4
		la $a0, ParseError
		syscall
		li $v0, 10
		syscall
	
	pushCurrent:
		#move $t2, $a0 #save the string
		lbu $a0, 0($s4)
		move $a1, $s2
		move $a2, $s3
		jal stack_push
		#move $a0, $t2
		move $s2, $v0
		#move $s3, $a2
		j eval_end
	
	openPar:
		#move $t2, $a0 #save the string
		lbu $a0, 0($s4)
		lbu $a1, 1($s4)
		move $a1, $s2
		move $a2, $s3
		jal stack_push
		#move $a0, $t2
		move $s2, $v0
		#move $s3, $a2
		j eval_end
	
	digit:
		li $t3, 10
		addi $t0, $t0, -48
		mult $t4, $t3
		mflo $t6
		add $t4, $t6, $t0
		
		lbu $t5, 1($s4)
		beqz $t5, nullDigit
		li $t9, '('
		beq $t5, $t9, illForm
		move $a0, $t5
		#move $t2, $a0 #save the string
		move $a0, $t5 #a0 register for is_digit
		jal is_digit
		move $t3, $v0 #save result of is_digit in t3
		#move $a0, $t2 #save a0 as the original string
		bnez $t3, digitReturn
		
		
		nullDigit:
		move $a0, $t4
		move $a1, $s0
		move $a2, $s1
		jal stack_push
		move $s0, $v0
		j eval_end
		#move $s1, $a2
		
		digitReturn:
			addi $s4, $s4, 1
			lbu $t0, 0($s4)
			j digit
		
		#j eval_end
	
	closePar:
		#move $t2, $a0 #save the string
		move $a0, $s2
		addi $a0, $a0, -4
		jal is_stack_empty
		move $t3, $v0 #save result of is_stack_empty in t3
		#move $a0, $t2 #save a0 as the original string
		#bnez $t3, popBrace
		bnez $t3, illForm
		
		#move $t2, $a0 #save the string
		move $a0, $s2
		move $a1, $s3
		addi $a0, $a0, -4
		jal stack_peek
		#move $a0, $t2
		li $t6, '('
		beq $v0, $t6, popBrace
		
		#move $t2, $a0 #save aExp
		
		
		addi $s0, $s0, -4
		move $a0, $s0 #tp val
		move $a1, $s1 #base addr val
		jal stack_pop
		move $t7, $v1 #val2
	
		addi $s0, $s0, -4
		move $a0, $s0 #tp val
		move $a1, $s1 #base addr val
		jal stack_pop
		move $t5, $v1 #val1
	
		addi $s2, $s2, -4
		move $a0, $s2 #tp op
		move $a1, $s3 #base addr op
		jal stack_pop
		move $t6, $v1 #op
	
		#apply bin op
		move $a0, $t5
		move $a1, $t6
		move $a2, $t7
		jal apply_bop
			
		move $a0, $v0
		move $a1, $s0
		move $a2, $s1
		jal stack_push
		move $s0, $v0	
		
		j closePar
		
		
		popBrace:
			addi $s2, $s2, -4 #subtract 4 for popping
			move $a0, $s2
			move $a1, $s3
			jal stack_pop
			move $s2, $v0
			#move $s3, $v1
			j eval_end

	
	eval_end:
		lw $ra, 0($sp)
		addi $sp, $sp, 4		
		lbu $t9, 1($s4) #set to the next element

		bne $t9, $zero, evalCase #if the next element isn't 0,
		beqz $t9, emptyOperations
		
	
	evalCase:
		addi $s4, $s4, 1
		j evalFunction
	
	emptyOperations:
		move $a0, $s2
		addi $a0, $a0, -4
		jal is_stack_empty
		move $t3, $v0 #save result of is_stack_empty in t3
		bnez  $t3, eval_end_2
		
		addi $s0, $s0, -4
		move $a0, $s0 #tp val
		move $a1, $s1 #base addr val
		jal stack_pop
		move $t7, $v1 #val2
		
		addi $s0, $s0, -4
		move $a0, $s0 #tp val
		move $a1, $s1 #base addr val
		jal stack_pop
		move $t5, $v1 #val1
		
		
		addi $s2, $s2, -4
		move $a0, $s2 #tp op
		move $a1, $s3 #base addr op
		jal stack_pop
		move $t6, $v1 #op
		li $t9, '('
		beq $t6, $t9, illForm
		li $t9, ')'
		beq $t6, $t9, illForm
		
		#apply bin op
		move $a0, $t5
		move $a1, $t6
		move $a2, $t7
		jal apply_bop
		
		move $a0, $v0
		move $a1, $s0
		move $a2, $s1
		move $s7, $v0
		jal stack_push
		move $s0, $v0
		#move $s1, $a2
		
		j emptyOperations
		
	
	eval_end_2:
		#lbu $a0, 0($s1)
		#move $v0, $a0
		addi $s0, $s0, -4
		move $a0, $s0 #tp val
		move $a1, $s1 #base addr val
		jal stack_pop
		bgtz $s0, illForm
		move $a0, $v1
		li $v0, 1
		syscall 
  		li $v0, 10
		syscall	

is_digit: # done
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	move $t8, $a0
	move $a0, $0
	addi $t1, $t1, 0
	li $t2, 48
	li $t3, 57
	bge $t8, $t2, next
	j is_digit_end
	next: 
		ble $t8, $t3, check
		j is_digit_end
	check: 
		addi $a0, $a0, 1
		j is_digit_end
	is_digit_end:
		move $v0, $a0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
  	jr $ra
 
stack_push:
	add $a2, $a1, $a2 # shift by the base address plus the top of the stack
	sw $a0, 0($a2) # store the element x at the top of the stack
	
	addi $a1, $a1, 4
	move $v0, $a1
	
	#lw $a0, 0($t2)	
  	jr $ra

stack_peek:
	# addi $a0, $a0, -4
	add $a1, $a0, $a1
	lw $v0, 0($a1)
  jr $ra

stack_pop:
	# addi $a0, $a0, -4
	add $a1, $a0, $a1
	move $v0, $a0
	lw $v1, 0($a1)
	
  	jr $ra

is_stack_empty:
	move $v0, $zero
	bltz $a0, printOne
	j is_stack_empty_end 
	printOne:
		addi $v0, $v0, 1
	is_stack_empty_end:
  		jr $ra

valid_ops: # done
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	move $t0, $a0
	move $a0, $0
	li $t1, '+'
	beq $t0, $t1, checkVOPs
	li $t1, '*'
	beq $t0, $t1, checkVOPs
	li $t1, '-'
	beq $t0, $t1, checkVOPs
	li $t1, '/'
	beq $t0, $t1, checkVOPs
	j valid_ops_end
	
	checkVOPs: 
		addi $v0, $v0, 1
		j valid_ops_end
	
	valid_ops_end:
		move $a0, $a0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
  	jr $ra

op_precedence: # done
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	move $t0, $a0
	move $v0, $zero
	li $t1, '+'
	beq $t0, $t1, check1st
	li $t1, '-'
	beq $t0, $t1, check1st
	li $t1, '*'
	beq $t0, $t1, check2nd
	li $t1, '/'
	beq $t0, $t1, check2nd
	
	j end10_op_precedence
	
	check1st: 
		addi $v0, $v0, 1
		j op_precendence_end
	
	check2nd: 
		addi $v0, $v0, 2
		j op_precendence_end
	
	end10_op_precedence:
		li $v0, 4
		la $a0, BadToken
		syscall
		li $v0, 10
		syscall
	
	op_precendence_end:
		move $a0, $a0
		
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	
	jr $ra

apply_bop:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $v0, $zero
	
	li $t3, '+'
	beq $t3, $t1, add_bop
	li $t3, '-'
	beq $t3, $t1, sub_bop
	li $t3, '*'
	beq $t3, $t1, mult_bop
	li $t3, '/'
	beq $t3, $t1, div_bop
	
	li $v0, 4
	la $a0, BadToken
	syscall
	li $v0, 10
	syscall
	
	add_bop:
		add $v0, $t0, $t2
		j apply_bop_end
	sub_bop:
		sub $v0, $t0, $t2
		j apply_bop_end
	mult_bop:
		mul $v0, $t0, $t2
		j apply_bop_end
	div_bop:
		beqz $t2, applyOp
		
		
		#slt $t3, $t0, 0
		bltz $t0, firstNegCheck
		bltz $t2, secondNegCheck
		div $t0, $t2
		mflo  $v0
		j apply_bop_end
		
		applyOp:
			li $v0, 4
			la $a0, ApplyOpError
			syscall
			li $v0, 10
			syscall
		
		firstNegCheck:
			bltz $t2, regularOp
			div $t0, $t2
			mflo  $v0
			mfhi $t8
			bnez $t8, subOne
			j apply_bop_end
		
		secondNegCheck:
			bltz $t0, regularOp
			div $t0, $t2
			mflo  $v0
			mfhi $t8
			bnez $t8, subOne
			j apply_bop_end
			
		subOne:
			addi $v0, $v0, -1
			j apply_bop_end
		
		regularOp:
			div $t0, $t2
			mflo  $v0
			j apply_bop_end

	apply_bop_end:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
  	jr $ra
