# add test cases to data section
# Test your code with different Network layouts
# Don't assume that we will use the same layout in all our tests
.data
Name1: .asciiz "Timmy"
Name2: .asciiz "Ali Tourre"
Name_prop: .asciiz "NAME"
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
   .byte 84 105 109 109 121 0 0 0 0 0 0 0 74 111 104 110 32 68 111 101 0 0 0 0 65 108 105 32 84 111 117 114 114 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
  #.byte 84 105 109 109 121 0 0 0 0 0 0 74 111 104 110 32 68 111 101 0 0 0 0 65 108 105 32 84 111 117 114 114 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 # .byte 84 105 109 109 121 0 0 0 0 0 0 74 111 104 110 32 68 111 101 0 0 0 65 108 105 32 84 111 117 114 114 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
   # set of edges (bytes 96 - 215)
  .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

.text:
main:
	la $a0, Network
	addi $t0, $a0, 36
	addi $t1, $a0, 48
	addi $t2, $a0, 60
	addi $t3, $a0, 72
	
	addi $a0, $a0, 96
	sw $t0, 0($a0) # 36
	sw $t2, 4($a0) # 60
	sw $t1, 12($a0) # 48
	sw $t2, 16($a0) # 60
	
	la $a0, Network
	la $a1, Name1
	la $a2, Name2
	jal is_friend_of_friend
	
	#write test code
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	li $v0, 10
	syscall
	
.include "hw4.asm"
