.data
.text
.globl main
main:

lui $t0, 0x8000 #  $t0 = -2147483648. Largest Negative value

addiu $t1, $t0, -1 # test shows how overflow sould be ingnored and reg value should be looped around.
				   # Expected: $t0 = 0x80000000 = -2147483648
				   #		   $t1 = 0x7FFFFFFF = 2147483647


halt # end