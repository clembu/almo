.data
  tab: .word 3, 33, 49, 4, 23, 12, 46, 21, 48, 2
  retour: .asciiz "\n"
.text
  .globl main

  main:
  #prologue
  addi  $29, $29, -16      # $29 = $29 + -8
  sw    $31, 12($29)    # save $31
  li    $4, 10    # taille = 10
  sw    $4, 8($29)    # save taille

  #body
  #call print
  la    $4, tab    # load tab
  lw    $5, 8($29)    # load taille
  jal    print        # jump to print and save position to $ra


  #call sort
  la    $4, tab    # load tab
  lw    $5, 8($29)    # load taille
  jal    sort        # jump to sort and save position to $ra


  la    $4, retour    # load "\n" as arg[0]
  li    $2, 4    # $2 = 4 -- print string
  syscall

  #call print
  la    $4, tab    # load tab
  lw    $5, 8($29)    # load taille
  jal    print        # jump to print and save position to $ra

  #return
  li    $2, 0    # $2 = 0 --- return 0

  #epilogue
  lw    $31, 12($29)    # restore $31
  addi  $29, $29, 16      # $29 = $29 + 16
  jr $31 # jump to $31

  print:
  #prologue
  addi  $29, $29, -8      # $29 = $29 - 8
  sw    $31, 4($29)    # save $31
  sw    $4, 8($29)    # save *tab
  sw    $5, 12($29)    # save taille
  #body
  li    $7, 0    # $7 = 0
  printall:
    lw    $8, 12($29)    # load taille
    sll   $8, $8, 2      # taille <= taille*4
    beq    $7, $8, endprintall  # if i == taille then endprintall
    lw    $9, 8($29)    # load *tab
    addu    $8, $7, $9    # $8 = i + *tab <=> *tab[i]
    lw    $4, 0($8)    # load tab[i] as arg[0]
    li    $2, 1    # $2 = 1 --- print int
    syscall
    la    $4, retour    # load "\n" as arg[0]
    li    $2, 4    # $2 = 4 -- print string
    syscall
    addi  $7, $7, 4      # $7 = $7 + 4
    j    printall        # jump to printall
  endprintall:
  #epilogue
  lw    $31, 4($29)    # restore $31
  addi  $29, $29, 8      # $29 = $29 + 8
  jr    $31          # jump to $31


  sort:
  #prologue
  addi  $29, $29, -36      # $29 = $29 - 36
  sw    $31, 32($29)    # save $31
  sw    $16, 28($29)    # save $16
  sw    $17, 24($29)    # save $17
  #body
  or    $16, $4, $0 # $16 <- *tab
  or    $17, $5, $0 # $17 <- taille
  li    $11, 2     # $11 = 2
  blt    $17, $11, sortEnd  # if taille < 2 then

  li    $8, 0    # valmax = 0
  li    $9, 0    # $9 = 0
  li    $11, 0    # $11 = 0 -- *tab[i] - *tab[0]
  loopMax:
    beq    $9, $17, endLoopMax  # if $9 == $17 then endLoopMax
    add    $12, $11, $16    # $12 = $11 + $16
    lw    $12, 0($12)    # tab[i]
    ble    $12, $8, loopMaxEndIf  # if tab[i] <= valmax then loopMax
    or    $8, $12, $0 #valmax = tab[i]
    or    $10, $9, $0
    loopMaxEndIf:
    addi  $9, $9, 1      # $9 = $9 + 1
    addi  $11, $11, 4      # $11 = $11 + 4
    j    loopMax        # jump to loopMax
  endLoopMax:
  #call swap
  or  $4, $16, $0
  or  $5, $10,  $0
  addi  $6, $17, -1      # $6 = $17 + -1
  jal    swap        # jump to swap and save position to $ra

  #call sort
  or  $4, $16, $0
  addi  $5, $17, -1      # $5 = $17 + -1
  jal    sort        # jump to sort and save position to $ra

  sortEnd:
  #epilogue
  lw    $31, 32($29)    # load $31
  lw    $16, 28($29)    # load $16
  lw    $17, 24($29)    # load $17
  addi  $29, $29, 36      # $29 = $29 + 36
  jr    $31          # jump to $31


  swap:
  #prologue
  addi  $29, $29, -8      # $29 = $29 + -8
  sw    $31, 4($29)    # save $31
  #body
  sll    $5, $5, 2    # shift i to i*4 (word size)
  sll    $6, $6, 2    # shift j to j*4 (word size)
  add    $9, $4, $5    # $9 = $4 + $5 -- *tab[i]
  lw    $8, 0($9)    # tmp <== tab[i]
  add    $10, $4, $6    # $10 = $4 + $6 -- *tab[j]
  lw    $4, 0($10)    # get tab[j] via $10
  sw    $4, 0($9)    # *tab[i] <== tab[j]
  sw    $8, 0($10)    # *tab[k] <== tmp

  #epilogue
  lw    $31, 4($29)    # restore $31
  addi  $29, $29, 8      # $29 = $29 + 8
  jr    $31          # jump to $31
