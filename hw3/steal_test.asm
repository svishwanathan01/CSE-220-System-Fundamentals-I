.data
destination_pocket: .byte 0
.align 2
state:        
    .byte 0         # bot_mancala       	(byte #0)
    .byte 0         # top_mancala       	(byte #1)
    .byte 6         # bot_pockets       	(byte #2)
    .byte 6         # top_pockets        	(byte #3)
    .byte 1         # moves_executed	(byte #4)
    .byte 'T'    # player_turn        		(byte #5)
    # game_board                     		(bytes #6-end)
    .asciiz
    "0004040404040404000505050100"
.text
.globl main
main:
la $a0, state
lb $a1, destination_pocket
jal steal
# You must write your own code here to check the correctness of the function implementation.

move $s0, $a0

move $a0, $v0
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
