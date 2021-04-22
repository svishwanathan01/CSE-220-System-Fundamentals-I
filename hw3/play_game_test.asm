.data
moves_filename: .asciiz "moves02.txt"
board_filename: .asciiz "game02.txt"
num_moves_to_execute: .word 10
moves: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.align 2
state:        
    .byte 0         # bot_mancala       	(byte #0)
    .byte 1         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 2         # moves_executed	(byte #4)
    .byte 'B'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    "0108070601000404040404040400"
.text
.globl main
main:
la $a0, moves_filename
la $a1, board_filename
la $a2, state
la $a3, moves
addi $sp, $sp, -4
lw $t0, num_moves_to_execute
sw $t0, 0($sp)
jal play_game
addi $sp, $sp, 4
# You must write your own code here to check the correctness of the function implementation.

move $a0, $v0
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall
move $a0, $v1
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

li $a0, 10
li $v0, 11
syscall

move $a0, $s2
jal print_board

#addi $s0, $s0, -32
#move $a0, $s0
#jal write_board

#
#

#
# li $v0, 1
# lbu $a0, 0($s2)
# syscall
# li $a0, ' '
# li $v0, 11
# syscall
#
# li $v0, 1
# lbu $a0, 1($s2)
# syscall
# li $a0, ' '
# li $v0, 11
# syscall
#
# li $v0, 1
# lbu $a0, 2($s2)
# syscall
# li $a0, ' '
# li $v0, 11
# syscall
#
# li $v0, 1
# lbu $a0, 3($s2)
# syscall
# li $a0, ' '
# li $v0, 11
# syscall
#
# li $v0, 1
# lbu $a0, 4($s2)
# syscall
# li $a0, ' '
# li $v0, 11
# syscall
#
# li $v0, 1
# lbu $a0, 5($s2)
# syscall
# li $a0, ' '
# li $v0, 11
# syscall
#
# li $v0, 11
# lbu $a0, 6($s2)
# syscall
# li $v0, 11
# lbu $a0, 7($s2)
# syscall
# li $v0, 11
# lbu $a0, 8($s2)
# syscall
# li $v0, 11
# lbu $a0, 9($s2)
# syscall
# li $v0, 11
# lbu $a0, 10($s2)
# syscall
# li $v0, 11
# lbu $a0, 11($s2)
# syscall
# li $v0, 11
# lbu $a0, 12($s2)
# syscall
# li $v0, 11
# lbu $a0, 13($s2)
# syscall
# li $v0, 11
# lbu $a0, 14($s2)
# syscall
# li $v0, 11
# lbu $a0, 15($s2)
# syscall
# li $v0, 11
# lbu $a0, 16($s2)
# syscall
# li $v0, 11
# lbu $a0, 17($s2)
# syscall
# li $v0, 11
# lbu $a0, 18($s2)
# syscall
# li $v0, 11
# lbu $a0, 19($s2)
# syscall
# li $v0, 11
# lbu $a0, 20($s2)
# syscall
# li $v0, 11
# lbu $a0, 21($s2)
# syscall
# li $v0, 11
# lbu $a0, 22($s2)
# syscall
# li $v0, 11
# lbu $a0, 23($s2)
# syscall
# li $v0, 11
# lbu $a0, 24($s2)
# syscall
# li $v0, 11
# lbu $a0, 25($s2)
# syscall
# li $v0, 11
# lbu $a0, 26($s2)
# syscall
# li $v0, 11
# lbu $a0, 27($s2)
# syscall
# li $v0, 11
# lbu $a0, 28($s2)
# syscall
# li $v0, 11
# lbu $a0, 29($s2)
# syscall
# li $v0, 11
# lbu $a0, 30($s2)
# syscall
# li $v0, 11
# lbu $a0, 31($s2)
# syscall
# li $v0, 11
# lbu $a0, 32($s2)
# syscall
# li $v0, 11
# lbu $a0, 33($s2)
# syscall
#
# li $a0, 10
# li $v0, 11
# syscall

#lbu $a0, 0($s3)
#li $v0, 1
#syscall
#li $a0, ' '
#li $v0, 11
#syscall

#lbu $a0, 1($s3)
#li $v0, 1
#syscall
#li $a0, ' '
#li $v0, 11
#syscall

#lbu $a0, 2($s3)
#li $v0, 1
#syscall
#li $a0, ' '
#li $v0, 11
#syscall

#lbu $a0, 3($s3)
#li $v0, 1
#syscall
#li $a0, ' '
#li $v0, 11
#syscall

#lbu $a0, 4($s3)
#li $v0, 1
#syscall
#li $a0, ' '
#li $v0, 11
#syscall


li $v0, 10
syscall

.include "hw3.asm"
