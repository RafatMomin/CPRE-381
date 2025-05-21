    .data
    .align 2              # Ensure proper alignment
value:  .word 0xABCDABCD  # A known value in memory

    .text
    .globl main
main:
    la $t0, value         # Loads the address of 'value' into $t0
    addi $t0, $t0, 1      # Misalign the address stored by adding 1 to $t0
    lw $t1, 0($t0)        # Attempt to load a word from the misaligned address
    # Should cause an exception (address error)

    li $v0, 10            # syscall: exit
    syscall


# Justification:
# Checks the lw instruction's behavior when attempting to load a word from a misaligned address.  
# Word loading/accessability in MIPS needs to be aligned to a divisible-by-4 offset (0x10010000, 0x10010004, 0x10010008, etc.) 
# If the processor is running correctly, it should raise an exception due to the misalignment


# Tested in MARS, works correctly, expected exception is thrown. The exception is "fetch address not aligned on word boundary"