.data
.text
.globl main
main:

    # Start Test 3: If the program counter value is beyond the written code, the program ends. 
    # This is more of an edge case, as you probably wouldn't try to jump over all your code
    # If the test is successful, the program ends because it dropped off the bottom 
    lui $t0, 0x0040
    addiu $t0, $t0, 0x0020 #address beyond the written instructions
    jr $t0
    # End Test 3
    
    # Exit program
    halt