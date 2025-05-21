.data
.text
.globl main
main:
    # Test 3: Jumping to an odd address
    # This test will check if the j instruction correctly handles jumping to an odd address
    # addi instructions are included to track and ensure the expected amount of jump instructions are being executed
    # Start Test
    start:
        addi $t0, $t0, 1
        j 0x00000001 # exception should be thrown here since address is not word aligned

        addi $t0, $t0, 1
        j end

    end:
        addi $t0, $t0, 1
  
    # End Test

    # Exit program
    halt
