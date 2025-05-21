# bltzal test 3
# (branch on less than zero and link)
#
# test description : testing that each branch works when it SHOUlD and the $ra is set CORRECTLY
#
# 

.data
     str1: .asciiz    "something is broken"
     str2: .asciiz    "success"
.text
.globl main
main:

	#start test : all of these should branch to goodcompare and branch jump to next instruction (ra set correctly)
	li $s0, -1
	bltzal $s0, goodcompare
	j broken
	li $s0, -2
	bltzal $s0, goodcompare
	j broken
	lui $s0, 0x8000
	bltzal $s0, goodcompare
	j broken
	lui $s0, 0xFFFF
	or $s0, 0xFFFF
	bltzal $s0, goodcompare
	j broken
	#end test
	
la $a0, str2
addi $v0, $0, 4
syscall
halt
goodcompare:
addi $ra, $ra, 4 #skip over broken jump and return to correct address (if works then bltzal setting ra works)
jr $ra 
broken: #something is broken if you got here
la $a0, str1
addi $v0, $0, 4
syscall	
halt
