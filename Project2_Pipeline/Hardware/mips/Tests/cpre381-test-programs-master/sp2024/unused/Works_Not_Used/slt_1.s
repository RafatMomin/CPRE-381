.data
.text
.globl main
main:
    # Start Test Case 1: First Source Register is Less Than the Second
    addi $t0, $zero, 5    # Set $t0 to 5. Expected output: $t0 = 0x00000005
    addi $t1, $zero, 10   # Set $t1 to 10. Expected output: $t1 = 0x0000000A
    slt  $t2, $t0, $t1    # Set $t2 to 1 since 5 is less than 10. Expected output: $t2 = 0x00000001
    # End Test
    
    # End Program
    halt