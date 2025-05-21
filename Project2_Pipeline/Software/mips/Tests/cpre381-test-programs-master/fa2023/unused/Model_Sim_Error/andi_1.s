.data
.text
.globl main
main:

	#Start Test Un/Signed: The negative will be added first, then it will and itself with the unsigned version of itself
	#Justification: This is to make sure that negative numbers are regarded the same as unsigned numbers (immediate wise)
	addi $1, $1, 0
	addi $2, $2, -1
	addi $3, $3, -2
	addi $4, $4, -3
	addi $5, $5, -4
	addi $6, $6, -5
	addi $7, $7, -6
	addi $8, $8, -7
	addi $9, $9, -8
	addi $10, $10, -9
	addi $11, $11, -10
	addi $12, $12, 0
	addi $13, $13, 0
	addi $14, $14, 0
	addi $15, $15, 0
	addi $16, $16, 0
	addi $17, $17, 0
	addi $18, $18, 0
	addi $19, $19, 0
	addi $20, $20, 2970668521
	addi $21, $21, 2970668522
	addi $22, $22, 2970668523
	addi $23, $23, 0
	addi $24, $24, 0
	addi $25, $25, 0
	addi $26, $26, 0
	addi $27, $27, 0
	addi $28, $28, 0
	addi $29, $29, 0
	addi $30, $30, -1610612736
	addi $31, $31, -2147483648
	
	
	andi $1, $1, 0
	andi $2, $2, 4294967295
	andi $3, $3, 4294967294
	andi $4, $4, 4294967293
	andi $5, $5, 4294967292
	andi $6, $6, 4294967291
	andi $7, $7, 4294967290
	andi $8, $8, 4294967289
	andi $9, $9, 4294967288
	andi $10, $10, 4294967287
	andi $11, $11, 4294967286
	andi $20, $20, -1324298775
	andi $21, $21, -1324298774
	andi $22, $22, -1324298773
	andi $30, $30, 2684354560
	andi $31, $31, 2147483648

halt
