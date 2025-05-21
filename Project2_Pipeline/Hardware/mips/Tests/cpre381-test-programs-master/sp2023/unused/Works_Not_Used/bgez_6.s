addi $s0, $zero, 0 # $s0 will store the number of failed bgez instructions

addi $t0, $zero, 1
addi $t1, $zero, 2
addi $t2, $zero, 4
addi $t3, $zero, 8
addi $t4, $zero, 16
addi $t5, $zero, 32
addi $t6, $zero, 64
addi $t7, $zero, 128
addi $t8, $zero, 256
addi $t9, $zero, 512

bgez $t0, label_0
addi $s0, $s0, 1

label_0:
bgez $t1, label_1
addi $s0, $s0, 1

label_1:
bgez $t2, label_2
addi $s0, $s0, 1

label_2:
bgez $t3, label_3
addi $s0, $s0, 1

label_3:
bgez $t4, label_4
addi $s0, $s0, 1

label_4:
bgez $t5, label_5
addi $s0, $s0, 1

label_5:
bgez $t6, label_6
addi $s0, $s0, 1

label_6:
bgez $t7, label_7
addi $s0, $s0, 1

label_7:
bgez $t8, label_8
addi $s0, $s0, 1

label_8:
bgez $t9, label_9
addi $s0, $s0, 1

label_9:
addi $t0, $zero, 1024
addi $t1, $zero, 2048
addi $t2, $zero, 4096
addi $t3, $zero, 8192
addi $t4, $zero, 16384
addi $t5, $zero, 32767
bgez $t0, label_10
addi $s0, $s0, 1

label_10:
bgez $t0, label_11
addi $s0, $s0, 1

label_11:
bgez $t0, label_12
addi $s0, $s0, 1

label_12:
bgez $t0, label_13
addi $s0, $s0, 1

label_13:
bgez $t0, label_14
addi $s0, $s0, 1

label_14:
bgez $t0, label_15
addi $s0, $s0, 1

label_15:
lui $t0, 1
lui $t1, 2
lui $t2, 4
lui $t3, 8
lui $t4, 16
lui $t5, 32
lui $t6, 64
lui $t7, 128
lui $t8, 256
lui $t9, 512

bgez $t0, label_16
addi $s0, $s0, 1

label_16:
bgez $t1, label_17
addi $s0, $s0, 1

label_17:
bgez $t2, label_18
addi $s0, $s0, 1

label_18:
bgez $t3, label_19
addi $s0, $s0, 1

label_19:
bgez $t4, label_20
addi $s0, $s0, 1

label_20:
bgez $t5, label_21
addi $s0, $s0, 1

label_21:
bgez $t6, label_22
addi $s0, $s0, 1

label_22:
bgez $t7, label_23
addi $s0, $s0, 1

label_23:
bgez $t8, label_24
addi $s0, $s0, 1

label_24:
bgez $t9, label_25
addi $s0, $s0, 1

label_25:
lui $t0, 1024
lui $t1, 2048
lui $t2, 4096
lui $t3, 8192
lui $t4, 16384
lui $t5, 32767
bgez $t0, label_26
addi $s0, $s0, 1

label_26:
bgez $t0, label_27
addi $s0, $s0, 1

label_27:
bgez $t0, label_28
addi $s0, $s0, 1

label_28:
bgez $t0, label_29
addi $s0, $s0, 1

label_29:
bgez $t0, label_30
addi $s0, $s0, 1

label_30:
bgez $t0, label_31
addi $s0, $s0, 1

label_31:
halt

# $s0 should be 0 here if the test was successful
