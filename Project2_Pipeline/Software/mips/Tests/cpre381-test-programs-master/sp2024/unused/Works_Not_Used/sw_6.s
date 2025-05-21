.data 
array1: .word 0

.text 
la $t0, array1 #to get base memory address

#Test Case 4:
#This test case will save to 8 seperate register values to 8 seperate addresses. This verifys that you can
#write to whichever memory address you need to and with however large of a word size you want. 

addi $t1, $zero, 4294967295
addi $t2, $zero, 195944160
addi $t3, $zero, 778240
addi $t4, $zero, 765184
addi $t5, $zero, 4294967295
addi $t6, $zero, 286331153
addi $t7, $zero, 4206166031
addi $t7, $zero, 3668970923

sw $t1, 64($t0)
sw $t2, 16($t0)
sw $t3, 20($t0)
sw $t4, 24($t0)
sw $t5, 36($t0)
sw $t6, 40($t0)
sw $t7, 0($t0)

halt
