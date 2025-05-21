#Test to show 
lui $t0, 65535 # Absolute maximum
lui $t0, 65536 # Should cause failure, greater than 16 bits

#TA edit
halt
