.data
.text
.globl main

main:
    j end_test               # Jump to the very end of the program
    nop                      # Delay slot filler

    # This part should be skipped by the jump to the end
    nop                      # Placeholder to demonstrate skip
    nop                      # Another placeholder

end_test:
    nop                      # Confirm we've reached the end

    # Exit program
    halt
