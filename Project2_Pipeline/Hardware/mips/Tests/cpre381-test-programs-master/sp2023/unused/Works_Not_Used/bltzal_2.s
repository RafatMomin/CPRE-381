# bltzal test 2
# (branch on less than zero and link)
#
# test description: checking to see that all comparisons or numbers >= 0 will NOT change the $ra value
#
# extension of first test, this time checking that $ra value is being preserved

.data
     str1: .asciiz    "something is broken"
     str2: .asciiz    "success"
.text
.globl main
main:

	#start test : none of these should branch to break (comparison is working)
	li $ra, 0 #set ra to 0 
	bltzal $zero, broken
	bne $ra, 0, broken 
	bltzal $0, broken
	bne $ra, 0, broken 
	li $s0, 1
	bltzal $s0, broken
	bne $ra, 0, broken 
	lui $s0, 0x7FFF
	ori $s0, 0xFFFF
	bltzal $s0, broken
	bne $ra, 0, broken 
	li $s0, 0
	bltzal $s0, broken
	bne $ra, 0, broken 
	#end test
		
la $a0, str2
addi $v0, $0, 4
syscall
halt
broken: #something is broken if you got here
la $a0, str1
addi $v0, $0, 4
syscall	
halt
