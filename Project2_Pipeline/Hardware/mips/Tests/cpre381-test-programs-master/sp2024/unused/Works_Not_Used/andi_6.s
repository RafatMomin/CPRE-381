# More test cases

addi $s0, $0, 0xffffffff
addi $s3, $0, 0xaaaaaaaa


andi $t0, $s0, 0x12345678
andi $t0, $t0, 0x11111111
andi $s0, $t0, 0xeeeeeeee

andi $t1, $s3, 0x88888888
andi $s3, $s3, 0x22222222


# Expected results:
# $s0 = 0x00000000
# $s3 = 0x22222222
# $t0 = 0x10101010
# $t1 = 0x88888888

halt
