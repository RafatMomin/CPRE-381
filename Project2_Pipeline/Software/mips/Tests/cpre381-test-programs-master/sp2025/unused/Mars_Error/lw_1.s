    .text
    .globl main
main:
    addiu $t0, $zero, 0   # Set $t0 to 0x00000000
    lw $t1, 0($t0)        # Attempt to load a word from address 0
    # Should cause an exception (address error)

    # Exit program
    addiu $v0, $zero, 10  # Set $v0 to 10 (syscall: exit)
    syscall

# Justification:
# Tests the lw instruction's ability to handle loading from memory address 0. 
# If the processor is running correcrly, an exception should be thrown, since the address of 0x00000000 is reserved.

# Tested in MARS, correct exception is thrown, giving "address out of range".

