.text
.globl main
  fact:
  #prologue
  addiu $29, $29, -8
  sw $31, 0($29)
  addiu $29, $29, -4
  #body

  #epilogue
  addiu $29, $29, 4
  lw $31, 0($29)
  addiu $29, $29, 8
  jr $31
##########################
  main:
  #prologue
  addiu $29, $29, -4
  sw $31, 0($29)
  addiu $29, $29, -4
  #body
  ori $4, $0, 5
  jal fact
  or $4, $0, $2
  ori $2, $0, 1
  syscall
  ori $2, $0, 0
  #epilogue
  addiu $29, $29, 4
  lw $31, 0($29)
  addiu $29, $29, 4
  jr $31
