# add test cases to data section
# Test your code with different Network layouts
# Don't assume that we will use the same layout in all our tests
.data
Name1: .asciiz "Cacophonix"
Name2: .asciiz "Getafix"
Frnd_prop: .asciiz "FRIEND"

Network:
  .word 5   #total_nodes (bytes 0 - 3)
  .word 10  #total_edges (bytes 4- 7)
  .word 12  #size_of_node (bytes 8 - 11)
  .word 12  #size_of_edge (bytes 12 - 15)
  .word 3   #curr_num_of_nodes (bytes 16 - 19)
  .word 2   #curr_num_of_edges (bytes 20 - 23)
  .asciiz "NAME" # Name property (bytes 24 - 28)
  .asciiz "FRIEND" # FRIEND property (bytes 29 - 35)
   # nodes (bytes 36 - 95)	
  .byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0	
   # set of edges (bytes 96 - 215)
  .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

.text:
main:
	#la $a0, Network
	#jal create_person
	#move $s0, $a0
	
	#la $a0, Network
	#la $a1, Name2
	#move $a2, $s0
	la $a0, Network
	addi $t0, $a0, 36
	addi $t1, $a0, 48
	addi $t2, $a0, 72
	addi $t3, $a0, 84
	
	addi $a0, $a0, 96
	sw $t0, 0($a0)
	sw $t2, 4($a0)
	sw $t1, 12($a0)
	sw $t2, 16($a0)
	
	la $a0, Network
	addi $a1, $a0, 72
	#la $a1, Name1
	#la $a2, Name2
	addi $a2, $a0, 48
	
	
	la $a3, Frnd_prop
	addi $sp, $sp, -4
	li $s1, 1
	sw $s1, 0($sp) 
	jal add_relation_property
	
	#write test code
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	li $v0, 10
	syscall
	
.include "hw4.asm"
