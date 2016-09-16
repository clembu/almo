#data section
.data
var1: .word 0x12
var2: .word 0x34
var3: .word 0

.text
.globl main
main:
la $8, var1
lw $16, 0($8)
la $8, var2
lw $17, 0($8)
add $16, $16, $17
la $8, var3
sw $16, 0($8)
ori $2, $0, 10
syscall
