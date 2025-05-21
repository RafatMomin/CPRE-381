.data 
array1: .word 0

.text 
la $t0, array1 #to get base memory address

#Test Case 1:
#save a value (0x0000FFFF) in an address with an offset. load word into register $t2, save the word into a register with an offset
#that will cause a word mislaligment exception since it is not offset by 4. This is a common exception with sw if not careful with 
#offsets.

addi $t1, $zero, 65535
sw $t1, 20($t0)
lw $t2, 20($t0)
sw $t2, 2($t0)
