.data
.text
.globl main
main:
    # Test Case 2: First Source Register is Equal to the Second
    addi $t0, $zero, 10   # Set $t0 to 10. Expected output: $t0 = 0x0000000A
    addi $t1, $zero, 10   # Set $t1 to 10. Expected output: $t1 = 0x0000000A
    slt  $t2, $t0, $t1    # Set $t2 to 0 since 10 is not less than 10. Expected output: $t2 = 0x00000000
    # End Test
    
    # End Program
    halt
