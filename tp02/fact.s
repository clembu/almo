.text
.globl main
  fact:
  #prologue
  addiu $29, $29, -16
  sw $31, 0($29)
  sw $16, 4($29)
  or $16, $0, $4

  #body
  bgtz $16, elseFact #if n >= 0
    ori $2, $0, 1 #return 1
    j endifFact
  elseFact:
    addi $8, $16, -1 #n-1
    or $4, $8, $0 #argument de fact
    jal fact #appelle a fact
    or $8, $2, $0 # recuperation de fact(n-1)
    mult $8, $16 # multiplication par n
    mflo $2 # return fact(n-1)*2
  endifFact:

  #epilogue
  lw $31, 0($29)
  lw $16, 4($29)
  addiu $29, $29, 16
  jr $31
##########################
  main:
  #prologue
  addiu $29, $29, -8
  sw $31, 0($29)

  #body
  ori $4, $0, 5
  jal fact
  or $4, $0, $2
  ori $2, $0, 1
  syscall
  ori $2, $0, 0

  #epilogue
  lw $31, 0($29)
  addiu $29, $29, 8
  jr $31
