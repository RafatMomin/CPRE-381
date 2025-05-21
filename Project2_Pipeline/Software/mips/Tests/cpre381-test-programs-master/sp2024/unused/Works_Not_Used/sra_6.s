.data
.text
.globl main
main:
    # Start Test (shift a negative immediate value)
    lui $t0, 0xABCD   #initial $t0 value
    ori $t0, $t0, 0xEF01  #initial $t0 value
    sra $t1, $t0, 0     # should copy $t0 into $t1 (no shift)
    # End Test

    # Exit program
    halt
