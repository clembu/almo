.data
	table: .asciiz "0123456789ABCDEF"
	string: .asciiz "0x--------"
	n: .word 0x5432ABCD
.text
	.globl main
	main:
	la $16, string #pointeur sur string[0]
	la $17, n #pointeur sur n
	lw $17, 0($17) #valeur de n
	la $18, table #pointeur sur table[0]
	addu $8, $0, $18 #pointeur sur table[q]
	addi $9, $16, 2#char *ps = &string[2]
	ori $10, $0, 32 #int i = 32
	while:
		addi $10, $10, -4 # i = i-4
		srl $11, $17, $10 # q = (n>>i)
		andi $11, $11, 0x0F # q = q & 0x0F
		add $8, $18, $11 # pq = *table[0] + q
 		lw $12, 0($8) # $12=*pq
		sw $12, 0($9) # *ps=$12
		addi $9, $9, 1 # ps++
	blez $10, endwhile
	j while
	endwhile:
	ori $2, $0, 10
	syscall
