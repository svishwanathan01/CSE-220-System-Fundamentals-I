.data
origin_pocket: .byte 0
.align 2
state:        
    .byte 1         # bot_mancala       	(byte #0)
    .byte 1         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 0         # moves_executed	(byte #4)
    .byte 'B'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    "0106070703000000010008080601"
.text
.globl main
main:
la $a0, state
lb $a1, origin_pocket
jal execute_move
# You must write your own code here to check the correctness of the function implementation.

#mult	$t0, $t1			# $t0 * $t1 = Hi and Lo registers
#mflo	$t2					# copy Lo to $t2

#div		$t0, $t1			# $t0 / $t1
#mflo	$t2					# $t2 = floor($t0 / $t1) 
#mfhi	$t3					# $t3 = $t0 mod $t1 

move $s0, $a0

move $a0, $v0
li $v0, 1
syscall
li $a0, 10
li $v0, 11
syscall

move $a0, $v1
li $v0, 1
syscall
li $a0, 10
li $v0, 11
syscall

li $v0, 1
lbu $a0, 0($s0)
syscall
li $a0, ' '
li $v0, 11
syscall

li $v0, 1
lbu $a0, 1($s0)
syscall
li $a0, ' '
li $v0, 11
syscall

li $v0, 1
lbu $a0, 2($s0)
syscall
li $a0, ' '
li $v0, 11
syscall

li $v0, 1
lbu $a0, 3($s0)
syscall
li $a0, ' '
li $v0, 11
syscall

li $v0, 1
lbu $a0, 4($s0)
syscall
li $a0, ' '
li $v0, 11
syscall

li $v0, 1
lbu $a0, 5($s0)
syscall
li $a0, ' '
li $v0, 11
syscall

li $v0, 11
lbu $a0, 6($s0)
syscall
li $v0, 11
lbu $a0, 7($s0)
syscall
li $v0, 11
lbu $a0, 8($s0)
syscall
li $v0, 11
lbu $a0, 9($s0)
syscall
li $v0, 11
lbu $a0, 10($s0)
syscall
li $v0, 11
lbu $a0, 11($s0)
syscall
li $v0, 11
lbu $a0, 12($s0)
syscall
li $v0, 11
lbu $a0, 13($s0)
syscall
li $v0, 11
lbu $a0, 14($s0)
syscall
li $v0, 11
lbu $a0, 15($s0)
syscall
li $v0, 11
lbu $a0, 16($s0)
syscall
li $v0, 11
lbu $a0, 17($s0)
syscall
li $v0, 11
lbu $a0, 18($s0)
syscall
li $v0, 11
lbu $a0, 19($s0)
syscall
li $v0, 11
lbu $a0, 20($s0)
syscall
li $v0, 11
lbu $a0, 21($s0)
syscall
li $v0, 11
lbu $a0, 22($s0)
syscall
li $v0, 11
lbu $a0, 23($s0)
syscall
li $v0, 11
lbu $a0, 24($s0)
syscall
li $v0, 11
lbu $a0, 25($s0)
syscall
li $v0, 11
lbu $a0, 26($s0)
syscall
li $v0, 11
lbu $a0, 27($s0)
syscall
li $v0, 11
lbu $a0, 28($s0)
syscall
li $v0, 11
lbu $a0, 29($s0)
syscall
li $v0, 11
lbu $a0, 30($s0)
syscall
li $v0, 11
lbu $a0, 31($s0)
syscall
li $v0, 11
lbu $a0, 32($s0)
syscall
li $v0, 11
lbu $a0, 33($s0)
syscall

#li $a0, ' '
#li $v0, 11
#syscall
#li $v0, 1
#move $a0, $s5
#syscall


li $v0, 10
syscall

.include "hw3.asm"
