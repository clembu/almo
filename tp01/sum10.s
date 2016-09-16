.text
.globl main
main:
li $16 10
li $17 0
loop1:
add $17, $17, $16
addi $16, -1
beq $16, $0, endloop1
j loop1
endloop1:
ori $2, $0, 10
syscall
