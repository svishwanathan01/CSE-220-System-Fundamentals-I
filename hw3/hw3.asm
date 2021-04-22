# Sabareesh Vishwanathan
# savishwanath
# 112585006 

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text

load_game:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 #state
	move $s1, $a1 #file name
	
	li $v0, 13 #open file
	move $a0, $s1
	li $a1, 0
	li $a2, 0
	syscall
	
	bltz $v0, fileError
	move $s2, $v0
	addi $sp, $sp, -4
	li $t9, 1
	#j fileWork
	characterLoop:
		move $t0, $zero
		addi $t0, $t0, -1
		li $t8, 1
		beq $t9, $t8, firstLine
		li $t8, 2
		beq $t9, $t8, secondLine
		li $t8, 3
		beq $t9, $t8, thirdLine
		li $t8, 4
		beq $t9, $t8, fourthLine
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		blez $v0, end
		lb $a0, 0($sp)
		li $v0, 11
		syscall
		j characterLoop
	
	firstLine:
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		bltz $v0, end #if there is an error when reading, end
		bltz $t0, firByLine #if t0 is 0, then it is the first character
		#lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		lb $t3, 0($sp) #set t3 as the char at
		beq $t3, $t8, firstLine #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t3, $t8, firstNext #if it is at \n, go to the next line
		
		li $t1, 10 #second character, multiply the first by 10 and add it to the other character
		#addi $t0, $t0, -48
		mult $t0, $t1
		mflo $t2
		addi $t3, $t3, -48
		add $t0, $t2, $t3 
		
	
		j firstLine
	
	firByLine: 
		lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		beq $t0, $t8, fileError #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t0, $t8, fileError
		addi $t0, $t0, -48 #convert to decimal
		j firstLine
	
	firstNext:
		#addi $s0, $s0, 1
		#sb $t0, 0($s0)
		sb $t0, 1($s0)
		j nextLine
	
	secondLine:
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		bltz $v0, end #if there is an error when reading, end
		bltz $t0, secByLine #if t0 is 0, then it is the first character
		#lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		lb $t3, 0($sp) #set t3 as the char at
		beq $t3, $t8, secondLine #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t3, $t8, secondNext #if it is at \n, go to the next line
		
		li $t1, 10 #second character, multiply the first by 10 and add it to the other character
		#addi $t0, $t0, -48
		mult $t0, $t1
		mflo $t2
		addi $t3, $t3, -48
		add $t0, $t2, $t3 
		
	
		j secondLine
	
	secByLine: 
		lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		beq $t0, $t8, fileError #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t0, $t8, fileError
		addi $t0, $t0, -48 #convert to decimal
		j secondLine
	
	secondNext:
		#addi $s0, $s0, -1
		sb $t0, 0($s0)
		j nextLine
	
	thirdLine:
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		bltz $v0, end #if there is an error when reading, end
		bltz $t0, thiByLine #if t0 is 0, then it is the first character
		#lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		lb $t3, 0($sp) #set t3 as the char at
		beq $t3, $t8, thirdLine #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t3, $t8, thirdNext #if it is at \n, go to the next line
		
		li $t1, 10 #second character, multiply the first by 10 and add it to the other character
		#addi $t0, $t0, -48
		mult $t0, $t1
		mflo $t2
		addi $t3, $t3, -48
		add $t0, $t2, $t3 
		
	
		j thirdLine
	
	thiByLine: 
		lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		beq $t0, $t8, fileError #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t0, $t8, fileError
		addi $t0, $t0, -48 #convert to decimal
		j thirdLine
	
	thirdNext:
		#addi $s0, $s0, 2
		#sb $t0, 0($s0)
		sb $t0, 2($s0)
		#addi $s0, $s0, 1
		#sb $t0, 0($s0)
		sb $t0, 3($s0)
		li $t0, 0
		sb $t0, 4($s0)
		li $t0, 'B'
		sb $t0, 5($s0)
		lb $t0, 1($s0) #get the stones in the top mancala to add to the game board
		addi $s0, $s0, 6 #move to 6th byte to add the game board
		li $t1, 10
		div $t0, $t1 # divide t0 and 10
		mflo $t2
		mfhi $t0
		#beqz $t2, oneChar #if quotient is 0, then there's only one character
		addi $t2, $t2, 48
		sb $t2, 0($s0) #save quotient as 6th byte (top mancala in game board)
		addi $s0, $s0, 1
		addi $t0, $t0, 48
		sb $t0, 0($s0) #save remainder as 7th byte (top mancala in game board)
		addi $s0, $s0, 1
		
		j nextLine
	
	fourthLine:
		#addi $s0, $s0, 2
		lbu $t7, 2($s0) # # of pocket
		#addi $s0, $s0, 7
		li $t5, 1 # row counter
		li $t6, 2 # # of row
		li $s3, 1
		li $s5, 0
		move $s4, $t7
		li $s7, 0
		
		fourthRead:
			li $v0, 14 #read file
			move $a0, $s2
			move $a1, $sp
			#la $a1, 0($sp)
			li $a2, 1
			syscall
			bltz $v0, end #if there is an error when reading, end
			beqz $v0, checkLineEnd
			
			lb $t0, 0($sp)
			li $t8, 10 #set t8 as \n
			beq $t0, $t8, checkLineEnd
			
			li $v0, 14 #read file
			move $a0, $s2
			move $a1, $sp
			#la $a1, 0($sp)
			li $a2, 1
			syscall
			blez $v0, end #if there is an error when reading, end
			
			lb $t1, 0($sp)
			li $t8, 10 #set t8 as \n
			beq $t1, $t8, checkLineEnd
			
			sb $t0, 0($s0)
			addi $s0, $s0, 1
			sb $t1, 0($s0)
			addi $s0, $s0, 1
			addi $s7, $s7, 1
			
			addi $t0, $t0, -48
			addi $t1, $t1, -48
			
			li $t2, 10
			mult $t0, $t2
			mflo $t0
			add $t0, $t0, $t1
			add $s5, $t0, $s5			
			j fourthRead
			
		checkLineEnd:
			beq $t5, $t6, addBottom
			addi $t5, $t5, 1
			j fourthRead
	
	
	addBottom:
		li $v0, 16 #close file
		move $a0, $s2
		syscall
		
		addi $sp, $sp, 4
		move $s6, $s7
		add $s7, $s7, $s7
		addi $s7, $s7, 8
		sub $s0, $s0, $s7
		
		lb $t0, 0($s0) #get the stones in the top mancala to add to the game board
		
		add $s0, $s0, $s7
		
		li $t1, 10
		div $t0, $t1 # divide t0 and 10
		mflo $t2
		mfhi $t0
		addi $t2, $t2, 48
		sb $t2, 0($s0) #save quotient as 0th byte (bot mancala in game board)
		addi $s0, $s0, 1
		addi $t0, $t0, 48
		sb $t0, 0($s0) #save remainder as 1th byte (bot mancala in game board)
		addi $s0, $s0, 1
		
		addi $s7, $s7, 2
		
		sub $s0, $s0, $s7
	
			
	checkPt1Error:
		lb $t0, 0($s0)
		add $s5, $s5, $t0
		lb $t0, 1($s0)
		add $s5, $s5, $t0
		
		li $t0, 99
		bgt $s5, $t0, tooManyStones
		li $v0, 1
		
		li $t0, 98
		bgt $s6, $t0, tooManyPockets
		move $v1, $s6
		j end
	
	tooManyStones:
		li $v0, 0
		
		li $t0, 98
		bgt $s6, $t0, tooManyPockets
		move $v1, $s6
		j end
	
	tooManyPockets:
		li $v1, 0
		j end
		
	
	
	nextLine:
		addi $t9, $t9, 1
		j characterLoop
		
	
    	
    fileError:
    	li $v0, -1
    	li $v1, -1
    	j end

	end:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	addi $sp, $sp, 28
	jr $ra
	
get_pocket:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	li $t0, 'B'
	beq $t0, $s1, valid_player
	li $t0, 'T'
	beq $t0, $s1, valid_player
	li $v0, -1
	j get_pocket_end
	
	valid_player:
		lb $t9, 2($s0)
		addi $t9, $t9, -1
		bgt $s2, $t9, distNotValid
		addi $s0, $s0, 8
		
		li $t0, 'B'
		beq $t0, $s1, bottom_player
		
		move $t0, $s2
		add $t0, $t0, $t0
		add $s0, $s0, $t0
		lb $t0, 0($s0)
		lb $t1, 1($s0)
		addi $t0, $t0, -48
		addi $t1, $t1, -48
		li $t2, 10
		mult $t0, $t2
		mflo $t0
		add $t0, $t0, $t1
		
		move $v0, $t0
		j get_pocket_end
		
		
		
		bottom_player:
			addi $t9, $t9, 1
			add $t9, $t9, $t9
			add $t9, $t9, $t9
			addi $t9, $t9, -2
			#addi $t9, $t9, 4
			add $s0, $s0, $t9
			sub $s0, $s0, $s2
			sub $s0, $s0, $s2
			
			lb $t0, 0($s0)
			lb $t1, 1($s0)
			addi $t0, $t0, -48
			addi $t1, $t1, -48
			li $t2, 10
			mult $t0, $t2
			mflo $t0
			add $t0, $t0, $t1
		
			move $v0, $t0
			
			
			j get_pocket_end
			
	
	distNotValid:
		li $v0, -1
		j get_pocket_end
	
	get_pocket_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		addi $sp, $sp, 28
		jr $ra
	
	
set_pocket:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
	li $t0, 99
	bgt $s3, $t0, sizeWrong
	bltz $s3, sizeWrong
	
	li $t0, 'B'
	beq $t0, $s1, valid_player_sp
	li $t0, 'T'
	beq $t0, $s1, valid_player_sp
	li $v0, -1
	j set_pocket_end
	
	valid_player_sp:
		lb $t9, 2($s0)
		addi $t9, $t9, -1
		bgt $s2, $t9, distNotValid_sp
		addi $s0, $s0, 8
		
		li $t0, 'B'
		beq $t0, $s1, bottom_player_sp
		
		move $t0, $s2
		add $t0, $t0, $t0
		add $s0, $s0, $t0
		
	
		li $t1, 10
		div $s3, $t1 # divide t0 and 10
		mflo $t2
		mfhi $t0
		
		addi $t2, $t2, 48
		addi $t0, $t0, 48
		
		sb $t2, 0($s0)
		sb $t0, 1($s0)
				
		move $v0, $s3
		j set_pocket_end
	
	bottom_player_sp:
		addi $t9, $t9, 1
		add $t9, $t9, $t9
		add $t9, $t9, $t9
		addi $t9, $t9, -2
		#addi $t9, $t9, 4
		add $s0, $s0, $t9
		sub $s0, $s0, $s2
		sub $s0, $s0, $s2
				
		li $t1, 10
		div $s3, $t1 # divide t0 and 10
		mflo $t2
		mfhi $t0
		
		addi $t2, $t2, 48
		addi $t0, $t0, 48
		
		sb $t2, 0($s0)
		sb $t0, 1($s0)
		
		move $v0, $s3
		j set_pocket_end
		
	distNotValid_sp:
		li $v0, -1
		j set_pocket_end
		
	sizeWrong:
		li $v0, -2
		j set_pocket_end
	
	set_pocket_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		addi $sp, $sp, 28
		jr $ra
	
collect_stones:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	li $t0, 'B'
	beq $t0, $s1, valid_player_cs
	li $t0, 'T'
	beq $t0, $s1, valid_player_cs
	li $v0, -1
	j collect_stones_end
	
	valid_player_cs:
		blez $s2, invalid_stones_cs
		li $t0, 'B'
		beq $t0, $s1, bottom_player_cs
		
		lb $t0, 1($s0)
		#addi $t0, $t0, -48
		add $t0, $t0, $s2
		#addi $t0, $t0, 48
		sb $t0, 1($s0)
		
		
		li $t1, 10
		div $t0, $t1 # divide s2 and 10
		mflo $t2
		mfhi $t0
		
		addi $t2, $t2, 48
		addi $t0, $t0, 48
		
		
		
		sb $t2, 6($s0)
		sb $t0, 7($s0)
		
		move $v0, $s2
		j collect_stones_end
		
		
	bottom_player_cs:
		lb $t0, 0($s0)
		#addi $t0, $t0, -48
		add $t0, $t0, $s2
		#addi $t0, $t0, 48
		sb $t0, 0($s0)
		
		lb $t1, 2($s0)
		addi $s0, $s0, 8
		add $t1, $t1, $t1
		add $t1, $t1, $t1
		add $s0, $s0, $t1
		
		li $t1, 10
		div $t0, $t1 # divide s2 and 10
		mflo $t2
		mfhi $t0
		
		addi $t2, $t2, 48
		addi $t0, $t0, 48
		
		sb $t2, 0($s0)
		sb $t0, 1($s0)
		
		move $v0, $s2
		j collect_stones_end
	
	invalid_stones_cs:
		li $v0, -2
		j collect_stones_end
		
	collect_stones_end:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		addi $sp, $sp, 28
		jr $ra

verify_move:
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
	

	move $s0, $a0 # state
	move $s1, $a1 # origin_pocket
	move $s2, $a2 # distance
	
	li $t0, 99
	beq $s2, $t0, change_turn
	beqz $s2, dist_zero
	
	lb $t0, 2($s0)
	bge $s1, $t0, invalid_row
	
	lb $t8, 5($s0)
	lb $t9, 2($s0)
	addi $s0, $s0, 8
	
	li $t0, 'B'
	beq $t0, $t8, B_pocket_vm
	
	
	
	#add $t9, $t9, $t9
	add $s0, $s0, $s1
	add $s0, $s0, $s1
	lb $t3, 0($s0)
	lb $t4, 1($s0)
	addi $t3, $t3, -48
	addi $t4, $t4, -48
	
	li $t5, 10
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t4
	beqz $t3, zero_stones
	bne $t3, $s2, dist_zero
	li $v0, 1
	j verify_move_end
	
	B_pocket_vm:
		#addi $t9, $t9, 1
		add $t9, $t9, $t9
		add $t9, $t9, $t9
		addi $t9, $t9, -2
		#addi $t9, $t9, 4
		add $s0, $s0, $t9
		sub $s0, $s0, $s1
		sub $s0, $s0, $s1
		
		lb $t3, 0($s0)
		lb $t4, 1($s0)
		addi $t3, $t3, -48
		addi $t4, $t4, -48
	
		li $t5, 10
		mult $t3, $t5
		mflo $t3
		add $t3, $t3, $t4
		beqz $t3, zero_stones
		bne $t3, $s2, dist_zero
		li $v0, 1
		j verify_move_end
	
	dist_zero:
		li $v0, -2
		j verify_move_end
	
	zero_stones:
		li $v0, 0
		j verify_move_end
	
	invalid_row:
		li $v0, -1
		j verify_move_end
	
	change_turn:
		li $t0, 'B'
		lb $t1, 5($s0)
		beq $t0, $t1, change_to_T
		sb $t0, 5($s0)
		
		lb $t0, 4($s0)
		addi $t0, $t0, 1
		sb $t0, 4($s0)
		
		li $v0, 2
		j verify_move_end
	
	change_to_T:
		li $t0, 'T'
		sb $t0, 5($s0)
		
		lb $t0, 4($s0)
		addi $t0, $t0, 1
		sb $t0, 4($s0)

		li $v0, 2
		j verify_move_end
		
	verify_move_end:
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
	
	
execute_move:
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

	move $s0, $a0 # state
	move $s1, $a1 # origin_pocket
	
	li $t0, 'B'
	lb $t1, 5($s0)
	beq $t0, $t1, right_move_start
	
	j left_move_start
	
	left_move_start:
		move $t6, $s1
		lb $t8, 5($s0)
		li $t7, 0
		lb $t9, 2($s0)
		addi $s0, $s0, 8
		add $s0, $s0, $s1
		add $s0, $s0, $s1
		
		lb $t3, 0($s0)
		lb $t4, 1($s0)
		addi $t3, $t3, -48
		addi $t4, $t4, -48
		
		li $t5, 10
		mult $t3, $t5
		mflo $t3
		add $t3, $t3, $t4
		
		li $t4, 48
		sb $t4, 0($s0)
		sb $t4, 1($s0)
		addi $t6, $t6, -1
		j left_move
	
	
	
	left_move:
		beqz $t3, check_v1
		bltz $t6, top_mancala
		
		move $a0, $a0
		move $a1, $t8
		move $a2, $t6
		jal get_pocket
		
		move $a0, $a0
		move $a1, $t8
		move $a2, $t6
		li $a3, 0
		add $a3, $a3, $v0
		addi $a3, $a3, 1
		jal set_pocket
		
		addi $t6, $t6, -1
		addi $t3, $t3, -1
	
		j left_move
		
	top_mancala:
		move $a0, $a0
		li $t5, 'B'
		lb $t0, 5($a0)
		beq $t0, $t5, top_mancala_end
		move $a1, $t0
		li $a2, 1
		jal collect_stones
		addi $t3, $t3, -1
		addi $t7, $t7, 1
		
		beqz $t3, last_dep_manc
		
		top_mancala_end:
		lbu $t6, 2($a0)
		addi $t6, $t6, -1
		li $t8, 'B'
		
		j right_move
		
	
	right_move_start:
		move $t6, $s1
		lb $t8, 5($s0)
		li $t7, 0
		lb $t9, 2($s0)
		#addi $s0, $s0, 8
		#add $s0, $s0, $t9
		#add $s0, $s0, $t9
		
		add $t9, $t9, $t9
		add $t9, $t9, $t9
		addi $t9, $t9, -2
		#addi $t9, $t9, 4
		addi $s0, $s0, 8
		add $s0, $s0, $t9
		sub $s0, $s0, $s1
		sub $s0, $s0, $s1
		#addi $s0, $s0, 0
		
		lb $t3, 0($s0)
		lb $t4, 1($s0)
		addi $t3, $t3, -48
		addi $t4, $t4, -48
		
		li $t5, 10
		mult $t3, $t5
		mflo $t3
		add $t3, $t3, $t4
		
		li $t4, 48
		sb $t4, 0($s0)
		sb $t4, 1($s0)
		addi $t6, $t6, -1
		
		# j deposit_end
		
		j right_move
	
	
	right_move:
		beqz $t3, check_v1
		bltz $t6, bottom_mancala
		
		move $a0, $a0
		move $a1, $t8
		move $a2, $t6
		jal get_pocket
		
		move $a0, $a0
		move $a1, $t8
		move $a2, $t6
		li $a3, 0
		add $a3, $a3, $v0
		addi $a3, $a3, 1
		jal set_pocket
		
		addi $t6, $t6, -1
		addi $t3, $t3, -1
		j right_move
	
	bottom_mancala:
		move $a0, $a0
		li $t5, 'T'
		lb $t0, 5($a0)
		beq $t0, $t5, bot_mancala_end
		move $a1, $t0
		li $a2, 1
		jal collect_stones
		addi $t3, $t3, -1
		addi $t7, $t7, 1
		
		beqz $t3, last_dep_manc
		bot_mancala_end:
			li $t8, 'T'
			lbu $t6, 2($a0)
			addi $t6, $t6, -1
		
			j left_move
	
	last_dep_manc:
		li $v1, 2
		j execute_move_end
	
	check_v1:
		li $v1, 0
		li $t0, 1
		beq $t0, $a3, check_v1_1
		j execute_move_end
	
	check_v1_1:
		lb $t0, 5($a0)
		bne $t0, $t8, execute_move_end
		li $v1, 1
		j execute_move_end
		
	execute_move_end:
	lb $t0, 4($a0)
	addi $t0, $t0, 1
	sb $t0, 4($a0)
	li $t0, 2
	beq $t0, $v1, em_end
	li $t0, 'B'
	lb $t1, 5($a0)
	beq $t0, $t1, change_to_T_em
	sb $t0, 5($a0)
	
	j em_end
	
	change_to_T_em:
		li $t0, 'T'
		sb $t0, 5($a0)
	
	em_end:
		move $v0, $t7
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
	
steal:
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

	move $s0, $a0 # state
	move $s1, $a1 # dest_pocket of former player
	
	lbu $t3, 5($s0) # player turn post execute move
	li $t0, 'B'
	beq $t3, $t0, former_T
	li $t4, 'B'
	j steal_start
	
	former_T:
		li $t4, 'T'
		j steal_start
	
	steal_start:
		move $t6, $s1
		lb $t0, 2($a0)
		addi $t0, $t0, -1
		sub $t5, $t0, $t6
		 
		move $a0, $a0
		move $a1, $t4
		move $a2, $t6
		jal get_pocket
		move $t8, $v0
		
		move $a0, $a0
		move $a1, $t4
		move $a2, $t6
		li $a3, 0
		jal set_pocket
		
		move $a0, $a0
		move $a1, $t3
		move $a2, $t5
		jal get_pocket
		move $t7, $v0
		
		move $a0, $a0
		move $a1, $t3
		move $a2, $t5
		li $a3, 0
		jal set_pocket
		
		add $t8, $t8, $t7
		
		move $a0, $a0
		move $a1, $t4
		move $a2, $t8
		jal collect_stones
		
	
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
		
check_row:
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
	move $s0, $a0 # state
	
	li $t3, 'T'
	li $t4, 'B'
	li $t5, 0
	li $t6, 0
	li $t7, 0
	lb $t8, 2($a0)
	
	top_stones_loop:
		beq $t7, $t8, bottom_stones_loop_setup
		move $a0, $s0
		move $a1, $t3
		move $a2, $t7
		jal get_pocket
		add $t5, $t5, $v0
		addi $t7, $t7, 1
		
		j top_stones_loop
		
	bottom_stones_loop_setup:
		li $t7, 0
	bottom_stones_loop:
		beq $t7, $t8, check_for_row_empty
		move $a0, $s0
		move $a1, $t4
		move $a2, $t7
		jal get_pocket
		add $t6, $t6, $v0
		addi $t7, $t7, 1	
		
		j bottom_stones_loop
	
	check_for_row_empty:
		beqz $t5, game_over
		beqz $t6, game_over
		li $v0, 0
		j compare_moves
	
	game_over:
		#li $v0, 1
		
		move $a0, $s0
		move $a1, $t3
		move $a2, $t5
		jal collect_stones
		
		move $a0, $s0
		move $a1, $t4
		move $a2, $t6
		jal collect_stones
		
		top_stones_zero_setup:
			li $t7, 0
			li $t3, 'T'
			
		top_stones_zero_loop:
			beq $t7, $t8, bottom_stones_zero_setup
			move $a0, $s0
			move $a1, $t3
			move $a2, $t7
			li $a3, 0
			jal set_pocket
			addi $t7, $t7, 1	
		
			j top_stones_zero_loop
		
		bottom_stones_zero_setup:
			li $t7, 0
			li $t3, 'B'
			
		bottom_stones_zero_loop:
			beq $t7, $t8, game_over_end
			move $a0, $s0
			move $a1, $t3
			move $a2, $t7
			li $a3, 0
			jal set_pocket
			addi $t7, $t7, 1	
		
			j bottom_stones_zero_loop
	
	game_over_end:
		li $v0, 1
		li $t0, 'D'
		sb $t0, 5($s0)
	
	compare_moves:
		lbu $t5, 1($s0)
		lbu $t6, 0($s0)
		bgt $t5, $t6, p2_greater
		blt $t5, $t6, p1_greater
		li $v1, 0
		j check_row_end
	
	p2_greater:
		li $v1, 2
		j check_row_end
	
	p1_greater:
		li $v1, 1
		j check_row_end
		
	check_row_end:
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
		
load_moves:
	addi $sp $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	
	move $s0, $a0 #moves
	move $s1, $a1 #file name
	
	li $v0, 13 #open file
	move $a0, $s1
	li $a1, 0
	li $a2, 0
	syscall
	
	bltz $v0, fileError_lm
	move $s2, $v0
	addi $sp, $sp, -4
	li $t9, 1
	li $s5, 0
	#j fileWork
	li $t7, 0
	characterLoop_lm:
		move $t0, $zero
		addi $t0, $t0, -1
		li $t8, 1
		beq $t9, $t8, firstLine_lm
		li $t8, 2
		beq $t9, $t8, secondLine_lm
		li $t8, 3
		beq $t9, $t8, thirdLine_lm
	
	firstLine_lm:
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		bltz $v0, end #if there is an error when reading, end
		bltz $t0, firByLine_lm #if t0 is 0, then it is the first character
		#lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		lb $t3, 0($sp) #set t3 as the char at
		beq $t3, $t8, firstLine_lm #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t3, $t8, firstNext_lm #if it is at \n, go to the next line
		
		li $t1, 10 #second character, multiply the first by 10 and add it to the other character
		#addi $t0, $t0, -48
		mult $t0, $t1
		mflo $t2
		addi $t3, $t3, -48
		add $t0, $t2, $t3 
		
	
		j firstLine_lm
	
	firByLine_lm: 
		lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		beq $t0, $t8, fileError #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t0, $t8, fileError
		addi $t0, $t0, -48 #convert to decimal
		j firstLine_lm
	
	firstNext_lm:
		#addi $s0, $s0, 1
		#sb $t0, 0($s0)
		#sb $t0, 1($s0)
		move $s3, $t0
		j nextLine_lm
		
		
	secondLine_lm:
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		bltz $v0, end_lm #if there is an error when reading, end
		bltz $t0, secByLine_lm #if t0 is 0, then it is the first character
		#lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		lb $t3, 0($sp) #set t3 as the char at
		beq $t3, $t8, secondLine_lm #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t3, $t8, secondNext_lm #if it is at \n, go to the next line
		
		li $t1, 10 #second character, multiply the first by 10 and add it to the other character
		#addi $t0, $t0, -48
		mult $t0, $t1
		mflo $t2
		addi $t3, $t3, -48
		add $t0, $t2, $t3 
		
	
		j secondLine_lm
	
	secByLine_lm: 
		lb $t0, 0($sp)
		li $t8, 13 #set t8 as \r
		beq $t0, $t8, fileError_lm #if it is at \r, do nothing
		li $t8, 10 #set t8 as \n
		beq $t0, $t8, fileError_lm
		addi $t0, $t0, -48 #convert to decimal
		j secondLine_lm
	
	secondNext_lm:
		#addi $s0, $s0, -1
		#sb $t0, 0($s0)
		move $s4, $t0
		j nextLine_lm	
		

	thirdLine_lm:
		beq $s5, $s3, add99
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		#la $a1, 0($sp)
		li $a2, 1
		syscall
		bltz $v0, end #if there is an error when reading, end
		beqz $v0, closeFile
		lb $t0, 0($sp)
		li $t8, 10 #set t8 as \n
		beq $t0, $t8, closeFile
		
		li $v0, 14 #read file
		move $a0, $s2
		move $a1, $sp
		li $a2, 1
		syscall
		blez $v0, closeFile #if there is an error when reading, end
		lb $t1, 0($sp)
		li $t8, 10 #set t8 as \n
		beq $t1, $t8, closeFile
		
		li $t2, 48
		blt $t0, $t2, invalidMove_lm
		blt $t1, $t2, invalidMove_lm
		li $t2, 58
		bgt $t0, $t2, invalidMove_lm
		bgt $t1, $t2, invalidMove_lm
		
		addi $t0, $t0, -48
		addi $t1, $t1, -48
			
		li $t2, 10
		mult $t0, $t2
		mflo $t0
		add $t0, $t0, $t1
		sb $t0, 0($s0)
		li $t8, 48
		bgt $t0, $t2, invalidMove_lm
		addi $s0, $s0, 1
		#add $s5, $t0, $s5			
		
		addi $s5, $s5, 1
		j thirdLine_lm

	add99:
		li $t2, 99
		sb $t2, 0($s0)
		addi $s0, $s0, 1
		li $s5, 0
		j thirdLine_lm
	
	invalidMove_lm:
		li $t2, 100
		sb $t2, 0($s0)
		addi $s0, $s0, 1
		addi $s5, $s5, 1
		j thirdLine_lm
	
	closeFile:
		li $v0, 16 #close file
		move $a0, $s2
		syscall
		
		addi $sp, $sp, 4
		
		j end_lm
	
	
	nextLine_lm:
		addi $t9, $t9, 1
		j characterLoop_lm
	
	fileError_lm:
    		li $v0, -1
    		li $v1, -1
    		j end_lm_2
		
	end_lm:
		addi $s0, $s0, -1
		li $t0, 0
		sb $t0, 0($s0)
		mult $s3, $s4
		mflo $t0
		add $t0, $t0, $s4
		sub $s0, $s0, $t0
		addi $t0, $t0, -1
		move $v0, $t0
		
		#move $a0, $s0
	end_lm_2:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $s4, 16($sp)
		lw $s5, 20($sp)
		lw $s6, 24($sp)
		addi $sp, $sp, 28
		jr $ra

play_game:
	lw $s4, 0($sp) # num_moves_to_execute
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $s0, $a0 # moves file
	move $s1, $a1 # board file
	move $s2, $a2 # state
	move $s3, $a3 # moves
		

	move $a0, $s2
	move $a1, $s1
	jal load_game
	blez $v0, fileError_pg
	blez $v1, fileError_pg

	move $a0, $s3
	move $a1, $s0
	jal load_moves
	bltz $v0, fileError_pg
	move $s5, $v0 # moves in the moves file
	li $s6, 0 # total number of moves, to check if it is equal to the moves in the file
	
	moves_loop_pg:
		lb $t0, 4($s2)
		bge $t0, $s4, no_error_pg
		beq $s6, $s5, no_error_pg
		addi $s6, $s6, 1
		
		li $t0, 99
		lb $t1, 0($s3)
		beq $t0, $t1, changeTurn_pg
		
		move $a0, $s2 # state
		lb $t0, 5($s2)
		lb $t1, 0($s3)
		move $a1, $t0 # player 
		move $a2, $t1 # distance
		jal get_pocket
		bltz $v0, inc_moves_loop_pg
		
		move $a0, $s2 # state
		# li $t0, 5($s2)
		lb $t1, 0($s3) 
		move $a1, $t1 # origin_pocket
		move $a2, $v0 # distance
		jal verify_move
		blez $v0, inc_moves_loop_pg
		li $t0, 2
		beq $t0, $v0, inc_moves_loop_pg
		
		move $a0, $s2 # state
		lb $t1, 0($s3) 
		move $a1, $t1 # origin_pocket
		jal execute_move
		li $t0, 1
		beq $t0, $v1, steal_pg
		
		j check_row_pg
		
		changeTurn_pg:
			move $a0, $s2 # state
			# li $t0, 5($s2)
			li $t1, 0
			move $a1, $t1 # origin_pocket
			li $a2, 99 # distance
			jal verify_move
			
			j inc_moves_loop_pg
		
		steal_pg:
			move $a0, $s2
			addi $t6, $t6, 1
			move $a1, $t6 # from execute_move, last pocket a stone was deposited in
			jal steal
			
			j check_row_pg
		
		check_row_pg:
			move $a0, $s2
			jal check_row
			bnez $v0, game_over_pg
			j inc_moves_loop_pg	
		
		inc_moves_loop_pg:
			addi $s3, $s3, 1
			j moves_loop_pg_end
		
		
		moves_loop_pg_end:
			j moves_loop_pg
	
	game_over_pg:
		move $v0, $v1
		lb $v1, 4($s2)
		j end_pg
	
	no_error_pg:
		li $v0, 0
		lb $v1, 4($s2)
		j end_pg
	
	fileError_pg:
		li $v0, -1
		li $v1, -1
		j end_pg
	
	end_pg:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	
print_board:
	move $s0, $a0
	lb $s1, 1($a0)
	lb $s2, 0($a0)
	
	li $t0, 10
	div $s1, $t0
	mflo $t1
	mfhi $t2
	
	addi $t1, $t1, 48
	addi $t2, $t2, 48
	
	li $v0, 11
	move $a0, $t1
	syscall
	li $v0, 11
	move $a0, $t2
	syscall
	li $a0, 10
	li $v0, 11
	syscall
	
	li $t0, 10
	div $s2, $t0
	mflo $t1
	mfhi $t2
	
	addi $t1, $t1, 48
	addi $t2, $t2, 48
	
	li $v0, 11
	move $a0, $t1
	syscall
	li $v0, 11
	move $a0, $t2
	syscall
	li $a0, 10
	li $v0, 11
	syscall
	
	lb $t0, 2($s0) # num of pockets in a row
	add $t1, $t0, $t0 # num of total pcckets
	addi $t1, $t1, 1
	# addi $t1, $t0, $t0
	li $t2, 0
	addi $s0, $s0, 8
	
	print_loop_pb:
		beq $t1, $t2, endOfBoard_pb
		beq $t2, $t0, addLine_pb
		li $v0, 11
		lbu $a0, 0($s0)
		syscall
		li $v0, 11
		lbu $a0, 1($s0)
		syscall
		addi $s0, $s0, 2
		addi $t2, $t2, 1
		j print_loop_pb
		
	endOfBoard_pb:
		li $a0, 10
		li $v0, 11
		syscall
		j end_pb
	
	addLine_pb:
		li $a0, 10
		li $v0, 11
		syscall
		addi $t2, $t2, 1
		j print_loop_pb
	
	
	end_pb:
	
		jr $ra

write_board:
	addi $sp $sp, -10
	li $t0, 't'
	sb $t0, 9($sp)
	li $t0, 'x'
	sb $t0, 8($sp)
	li $t0, 't'
	sb $t0, 7($sp)
	li $t0, '.'
	sb $t0, 6($sp)
	li $t0, 't'
	sb $t0, 5($sp)
	li $t0, 'u'
	sb $t0, 4($sp)
	li $t0, 'p'
	sb $t0, 3($sp)
	li $t0, 't'
	sb $t0, 2($sp)
	li $t0, 'u'
	sb $t0, 1($sp)
	li $t0, 'o'
	sb $t0, 0($sp)
	
	move $s0, $a0
	
	li $v0, 13
	move $a0, $sp
	li $a1, 1
	li $a2, 0
	syscall
	move $s7, $v0
	addi $sp $sp, 10
	
	addi $sp $sp, -1
	li $t0, 10
	sb $t0, 0($sp)
	
	#li $t1, '\n'
	#sw $t1, 0($t0)
	lb $t1, 2($s0) # num of pockets
	add $t1, $t1, $t1
	
	addi $s0, $s0, 6
	
	li $v0, 15
	move $a0, $s7
	move $a1, $s0
	li $a2, 2
	syscall
	
	li $v0, 15
	move $a0, $s7
	move $a1, $sp
	li $a2, 1
	syscall
	
	#add new line here
	
	addi $s0, $s0, 2
	add $s0, $s0, $t1
	add $s0, $s0, $t1
	
	li $v0, 15
	move $a0, $s7
	move $a1, $s0
	li $a2, 2
	syscall
	
	
	li $v0, 15
	move $a0, $s7
	move $a1, $sp
	li $a2, 1
	syscall
	
	#add new line here
	
	sub $s0, $s0, $t1
	sub $s0, $s0, $t1
	
	#add $t1, $t1, $t1
	
	li $v0, 15
	move $a0, $s7
	move $a1, $s0
	move $a2, $t1
	syscall
	
	
	li $v0, 15
	move $a0, $s7
	move $a1, $sp
	li $a2, 1
	syscall
	
	#add new line here
	
	add $s0, $s0, $t1
	
	li $v0, 15
	move $a0, $s7
	move $a1, $s0
	move $a2, $t1
	syscall
	
	li $v0, 15
	move $a0, $s7
	move $a1, $sp
	li $a2, 1
	syscall
	
	#add new line here
	
	li $v0, 16
	move $a0, $s7
	syscall
	
	addi $sp $sp, 1
	
	jr $ra
	
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
