#Test Case 2: Jumping to an Edge Address
#Ensures j can jump to a distant label correctly.

.text
.globl main
main:
j far_location
li $t0, 4
.align 2
far_location:
li $t1, 5
li $v0, 10
syscall

