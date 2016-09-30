.data
  tab: .word 23, 7, 12 ,513 ,-1
.text
  .globl main

  main:

  #prologue
  addiu $29, $29, -12
  sw $31, 0($29)


  #body
  la $4, tab
  jal arimean
  or $4, $2, $0
  ori $2, $0, 1
  syscall
  ori $2, $0 ,0

  #epilogue
  lw $31, 0($29)
  addiu $29, $29, 12
  jr $31


  arimean:
  #prologue
  addiu $29, $29, -20
  sw $31, 0($29)
  sw $16, 4($29) #t[]
  sw $17, 8($29) #n
  sw $18, 12($29) #x
  or $16, $0, $4

  #body
  or $4, $16,$0   #
  jal sizetab     # int n = sizetab(t)
  or $17, $2, $0  #

  or $4, $16, $0  #
  jal sumtab      # int x = sumtab(t)
  or $18, $2, $0  #

  div $18, $17
  mflo $2
  #epilogue
  lw $31, 0($29)
  lw $16, 4($29)
  lw $17, 8($29)
  lw $18, 12($29)
  addiu $29, $29, 20
  jr $31

  sizetab:
  #prologue
  addiu $29, $29, -12
  sw $31, 0($29)
  sw $16, 4($29)
  #body
  or $16, $0, 0 #index=0;
  sizeTabLoop:
    sll $8, $16, 2 #addresse de t[index] relative a t
    addu $8, $4, $8 #adresse de t[index]
    lw $9, 0($8) #valeur de t[index] dans $9
    blez $9, endSizeTabLoop #si negatif, sort de boucle
    addiu $16, $16, 1 #index++
    j sizeTabLoop
  endSizeTabLoop:
  or $2, $16, $0 #return index
  #epiloguesumTabL  lw $31, 0($29)
  lw $16, 4($29)
  addiu $29, $29, 12
  jr $31


  sumtab:
  #prologue
  addiu $29, $29, -20
  sw $31, 0($29)
  sw $16, 4($29)
  sw $17, 8($29)
  #body
  or $16, $0, $4 #pointeur sur t[0];
  ori $17, $0, 0 #accu = 0;
  sumTabLoop:
    lw $8, 0($16) #valeur de t[index] dans $8
    blez $8, endsumTabLoop #si negatif, sort de boucle
    add $17, $17, $8 #accu += t[index]
    addiu $16, $16, 4 #index++
    j sumTabLoop
  endsumTabLoop:
  or $2, $17, $0 #return accu
  #epilogue
  lw $31, 0($29)
  lw $16, 4($29)
  lw $17, 8($29)
  addiu $29, $29, 20
  jr $31
