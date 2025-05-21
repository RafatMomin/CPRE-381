.data
myArray: .word 2, 4, 6, 8, 10  # an array of integers

.text
.globl main
main:
    # Test Case 1: Load an array element into a register
    lw $t0, myArray($0)      # load the first element of the array into $t0
    li $t1, 2                # load the expected value into $t1
    bne $t0, $t1, error1     # if $t0 != $t1, branch to error1
    j done                   # jump to the end of the program

error1:
    li $v0, 10               # print an error message and exit
    syscall

    # Test Case 2: Load an array element using an offset
    li $t2, 8                # load the byte offset of the third element of the array
    lw $t3, myArray($t2)     # load the third element of the array into $t3
    li $t4, 6                # load the expected value into $t4
    bne $t3, $t4, error2     # if $t3 != $t4, branch to error2
    j done                   # jump to the end of the program

error2:
    li $v0, 10               # print an error message and exit
    syscall

    # Test Case 3: Load a negative byte offset
    li $t5, -4               # load the byte offset of the fourth element of the array
    lw $t6, myArray($t5)     # load the fourth element of the array into $t6
    li $t7, 8                # load the expected value into $t7
    bne $t6, $t7, error3     # if $t6 != $t7, branch to error3
    j done                   # jump to the end of the program

error3:
    li $v0, 10               # print an error message and exit
    syscall

    # End of program
done:
    halt
