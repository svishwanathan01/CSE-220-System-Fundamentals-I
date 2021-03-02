.data
ErrMsg: .asciiz "Invalid Argument"
WrongArgMsg: .asciiz "You must provide exactly two arguments"
EvenMsg: .asciiz "Even"
OddMsg: .asciiz "Odd"
#added
O: .asciiz "O"
S: .asciiz "S"
T: .asciiz "T"
I: .asciiz "I"
E: .asciiz "E"
C: .asciiz "C"
X: .asciiz "X"
M: .asciiz "M"
A: .asciiz "A"
B: .asciiz "B"
D: .asciiz "D"
F: .asciiz "F"
x: .asciiz "x"
Zero: .asciiz "0"
One: .asciiz "1"
Two: .asciiz "2"
Three: .asciiz "3"
Four: .asciiz "4"
Five: .asciiz "5"
Six: .asciiz "6"
Seven: .asciiz "7"
Eight: .asciiz "8"
Nine: .asciiz "9"
Working: .asciiz "Working"
WorkingFor: .asciiz "For is working"
Check: .asciiz "="
NewLine: .asciiz "\n"
BinaryList: .space 32
Period: .asciiz "."

A_1010_Dec: .word 10
B_1001_Dec: .word 11
C_1100_Dec: .word 12
D_1101_Dec: .word 13
E_1110_Dec: .word 14
F_1111_Dec: .word 15
Zero_0000_Dec: .word 0
One_0001_Dec: .word 1
Two_0010_Dec: .word 2
Three_0011_Dec: .word 3
Four_0100_Dec: .word 4
Five_0101_Dec: .word 5
Six_0110_Dec: .word 6
Seven_0111_Dec: .word 7
Eight_1000_Dec: .word 8
Nine_1001_Dec: .word 9

A_1010: .word 1010
B_1001: .word 1001
C_1100: .word 1100
D_1101: .word 1101
E_1110: .word 1110
F_1111: .word 1111
Zero_0000: .word 0000
One_0001: .word 0001
Two_0010: .word 0010
Three_0011: .word 0011
Four_0100: .word 0100
Five_0101: .word 0101
Six_0110: .word 0110
Seven_0111: .word 0111
Eight_1000: .word 1000
Nine_1001: .word 1001


arg1_addr : .word 0
arg2_addr : .word 0
num_args : .word 0

.text:
.globl main
main:
	sw $a0, num_args

	lw $t0, 0($a1)
	sw $t0, arg1_addr
	lw $s1, arg1_addr

	lw $t1, 4($a1)
	sw $t1, arg2_addr
	lw $s2, arg2_addr

	j start_coding_here

# do not change any line of code above this section
# you can add code to the .data section
start_coding_here:
	#if(a0 != 'O' || a0 != 'S' || a0 != 'T' || a0 != 'I' || a0 != 'E' || a0 != 'C' || a0 != 'X' || a0 != 'M') return ErrMsg
	#Till Line 83 (bne $s7, $t0, ErrorMessage)
	#addi $t0, $0, 0
	addi $t0, $0, 2
	bne $a0, $t0, ErrorMessage
	
	lbu $t0, 0($s1)
	
	la $t1, O
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, S
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, T
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, I
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, E
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, C
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, X
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t1, M
	lbu $t2, 0($t1)
	beq $t2, $t0, Operations
	
	la $t0, Check
	bne $t3, $t0, ErrorMessage
	
Operations:
	# li $v0, 4
	# la $a0, Working
	# syscall
	# li $v0, 4
	# la $a0, NewLine
	# syscall
	la $t3, Check
 	j FirstChar

FirstChar:
	lbu $t0, 0($s2)
	la $t1, Zero
	lbu $t2, 0($t1)
	beq $t0, $t2, SecondChar
	bne $t0, $t2, ErrorMessage

SecondChar:
	lbu $t0, 1($s2)
	la $t1, x
	lbu $t2, 0($t1)
	beq $t0, $t2, CheckChar
	bne $t0, $t2, ErrorMessage

# RestChar: 
#	addi $t0, $0, 1
#	addi $t1, $0, 10

CheckChar: 
	lw $t0, arg2_addr
	addi $t2, $0, 0
	addi $t3, $0, 10
	addi $t6, $0, 0
	addi $t7 $0, 1
	j ForChar

ForChar:
	beq $t2, $t3, ToBinary
	lbu $t1, 0($t0)
	
	beq $t2, $t6, IncrementForChar
	beq $t2, $t7, IncrementForChar
	
	la $t4, Zero
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, A
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, B
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, C
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, D
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, E
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, F
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
			
	la $t4, One
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Two
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Three
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Four
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Five
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Six
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Seven
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Eight
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	la $t4, Nine
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForChar
	
	j ErrorMessage

IncrementForChar:
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	j ForChar
	#j WorkingFor

ToBinary:
	move $t0, $s2
	move $t2, $zero
	move $t1, $zero
	addi $t2, $0, 0
	move $t3, $zero
	addi $t3, $0, 10
	move $t6, $zero
	addi $t6, $0, 0
	move $t7, $zero
	addi $t7 $0, 1
	move $s6, $zero
	addi $s6, $0, 0
	move $t9, $zero
	addi $t9 $0, 36
	j ForToBinary
	
ForToBinary:
	beq $t2, $t3, Instructions
	lbu $t1, 0($t0)
	
	beq $t2, $t6, IncrementForToBinary
	beq $t2, $t7, IncrementForToBinary
	
	la $t4, Zero
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, A
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseAlpha
	
	la $t4, B
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseAlpha
	
	la $t4, C
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseAlpha
	
	la $t4, D
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseAlpha
	
	la $t4, E
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseAlpha
	
	la $t4, F
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseAlpha
			
	la $t4, One
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Two
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Three
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Four
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Five
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Six
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Seven
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Eight
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum
	
	la $t4, Nine
	lbu $t5, 0($t4)
	beq $t1, $t5, CaseNum

CaseNum:
	addi $t8, $t5, -48
	sllv $t8, $t8, $t9
	or $s6, $s6, $t8
	j IncrementForToBinary
	

CaseAlpha:
	addi $t8, $t5, -55
	sllv $t8, $t8, $t9
	or $s6, $s6, $t8
	j IncrementForToBinary


IncrementForToBinary: 
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	#addi $s4, $s4, 4
	addi $t9, $t9, -4
	#addi $t8, $t8, 1
	j ForToBinary

Instructions:
	move $t0, $s1
	lbu $t2, 0($t0)
	
	la $t1, O
	lbu $t7, 0($t1)
	beq $t2, $t7, Opcode
	
	la $t1, S
	lbu $t7, 0($t1)
	beq $t2, $t7, RS
	
	la $t1, T
	lbu $t7, 0($t1)
	beq $t2, $t7, RT
	
	la $t1, I
	lbu $t7, 0($t1)
	beq $t2, $t7, Immediate
	
	la $t1, E
	lbu $t7, 0($t1)
	beq $t2, $t7, EvenOdd
	
	la $t1, C
	lbu $t7, 0($t1)
	beq $t2, $t7, Counting
	
	la $t1, X
	lbu $t7, 0($t1)
	beq $t2, $t7, Exponent
	
	la $t1, M
	lbu $t7, 0($t1)
	beq $t2, $t7, Mantissa

Opcode:
	srl $s6, $s6, 26
	li $v0, 1
    	move $a0, $s6
    	syscall
    	j Exit

RS:
	sll $s6, $s6, 6
	srl $s6, $s6, 27
	li $v0, 1
    	move $a0, $s6
    	syscall
    	j Exit
RT:
	sll $s6, $s6, 11
	
	srl $s6, $s6, 27
	li $v0, 1
    	move $a0, $s6
    	syscall
    	j Exit
Immediate:
	sll $s6, $s6, 16
	sra $s6, $s6, 16
	li $v0, 1
    	move $a0, $s6
    	syscall
    	j Exit

EvenOdd:
	move $t0, $s2
	move $t1, $zero
	move $t2, $zero
	addi $t2, $0, 0
	move $t3, $zero
	addi $t3, $0, 9
	move $t6, $zero
	addi $t6, $0, 0
	j ForEvenOdd

ForEvenOdd:
	#beq $t2, $t3, Exit
	lbu $t1, 0($t0)
	bne $t2, $t3, IncrementForEvenOdd
	
	la $t4, Zero
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, A
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, B
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	
	la $t4, C
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, D
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	
	la $t4, E
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, F
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
			
	la $t4, One
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	
	la $t4, Two
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, Three
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	
	la $t4, Four
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, Five
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	
	la $t4, Six
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, Seven
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	
	la $t4, Eight
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintEven
	
	la $t4, Nine
	lbu $t5, 0($t4)
	beq $t1, $t5, PrintOdd
	

IncrementForEvenOdd:
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	j ForEvenOdd

Counting:
	move $t0, $s2
	move $t1, $zero
	move $t2, $zero
	addi $t2, $0, 0
	move $t3, $zero
	addi $t3, $0, 10
	move $t6, $zero
	addi $t6, $0, 0
	move $t7, $zero
	addi $t7, $0, 0
	move $t8, $zero
	addi $t8, $0, 1
	j ForCounting

ForCounting:
	#beq $t2, $t3, Exit
	beq $t2, $t3, PrintCounting
	lbu $t1, 0($t0)
	beq $t2, $t7, IncrementForCounting
	beq $t2, $t8, IncrementForCounting
	
	
	la $t4, Zero
	lbu $t5, 0($t4)
	beq $t1, $t5, IncrementForCounting
	
	la $t4, A
	lbu $t5, 0($t4)
	beq $t1, $t5, AddTwo
	
	la $t4, B
	lbu $t5, 0($t4)
	beq $t1, $t5, AddThree
	
	la $t4, C
	lbu $t5, 0($t4)
	beq $t1, $t5, AddTwo
	
	la $t4, D
	lbu $t5, 0($t4)
	beq $t1, $t5, AddThree
	
	la $t4, E
	lbu $t5, 0($t4)
	beq $t1, $t5, AddThree
	
	la $t4, F
	lbu $t5, 0($t4)
	beq $t1, $t5, AddFour
			
	la $t4, One
	lbu $t5, 0($t4)
	beq $t1, $t5, AddOne
	
	la $t4, Two
	lbu $t5, 0($t4)
	beq $t1, $t5, AddOne
	
	la $t4, Three
	lbu $t5, 0($t4)
	beq $t1, $t5, AddTwo
	
	la $t4, Four
	lbu $t5, 0($t4)
	beq $t1, $t5, AddOne
	
	la $t4, Five
	lbu $t5, 0($t4)
	beq $t1, $t5, AddTwo
	
	la $t4, Six
	lbu $t5, 0($t4)
	beq $t1, $t5, AddTwo
	
	la $t4, Seven
	lbu $t5, 0($t4)
	beq $t1, $t5, AddThree
	
	la $t4, Eight
	lbu $t5, 0($t4)
	beq $t1, $t5, AddOne
	
	la $t4, Nine
	lbu $t5, 0($t4)
	beq $t1, $t5, AddTwo

AddOne:
	addi, $t6, $t6, 1
	j IncrementForCounting
AddTwo:
	addi, $t6, $t6, 2
	j IncrementForCounting
AddThree:
	addi, $t6, $t6, 3
	j IncrementForCounting
AddFour:
	addi, $t6, $t6, 4
	j IncrementForCounting

IncrementForCounting:
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	j ForCounting

PrintCounting:
	li $v0, 1
    	move $a0, $t6
    	syscall
    	j Exit
 	
	
Exponent:
	sll $s6, $s6, 1
	srl $s6, $s6, 24
	addi $s6, $s6, -127
	li $v0, 1
    	move $a0, $s6
    	syscall
    	j Exit
    	
Mantissa:
	li $v0, 4
	la $a0, One
	syscall	
	li $v0, 4
	la $a0, Period
	syscall
	sll $s6, $s6, 9
	li $v0, 35
    	move $a0, $s6
    	syscall
    	j Exit

RestDone:
	li $a0, 4
	la $a0, WorkingFor
	li $v0, 1
    	move $a0, $t8
    	syscall
	
	
PrintEven:
	li $v0, 4
	la $a0, EvenMsg
	syscall
	j Exit
	
PrintOdd:
	li $v0, 4
	la $a0, OddMsg
	syscall
	j Exit
	
ErrorMessage:
	li $v0, 4
	la $a0, ErrMsg
	syscall
	j Exit

Exit:	
	li $v0, 10
	syscall



	
	
	
	

