.data
filename: .asciiz "moves02.txt"
.align 0
moves: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
.globl main
main:
la $a0, moves
la $a1, filename
jal load_moves

# You must write your own code here to check the correctness of the function implementation.
#move $s0, $a0


move $a0, $v0
li $v0, 1
syscall
li $a0, 10
li $v0, 11
syscall

#addi $s0, $s0, -6

lbu $a0, 0($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 1($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 2($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 3($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 4($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 5($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 6($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 7($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 8($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 9($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 10($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 11($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 12($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 13($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 14($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 15($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 16($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall

lbu $a0, 17($s0)
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall




li $v0, 10
syscall

.include "hw3.asm"
