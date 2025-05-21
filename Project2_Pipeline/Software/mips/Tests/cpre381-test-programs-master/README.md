# CprE 381(0) Test Programs
This repository contains student writtent assemble unit test programs.

## Folder Structure
```
<semester>
|-> base
|  |-> <tests>.s
|-> unused
    |-> Mars_Error
    |-> ModelSimError
    |-> Works_Not_Used   

```

We have three categories for unused tests. If MARS/RARS errors, we will put it into Mars_Error. If it fails while testing against the reference MIPS CPU, we will put it into ModelSimError, and if we have too many tests it will go into Works_Not_Used

Tests that will be used will go into base. We should aim for about 5 tests for each instructions.

## Mars Testing
This is the 1st of 2 testing steps. You will run each test with the 381 version of RARS/MARS. If there are any warnings or errors, the test should go into Mars_Error. 

If you downloaded all of the HW submissions and are in the command line, the fastest way to check this is to run
```bash
java -jar <381_MARS.jar> <test>.s
```
Which will print the trace so you can quicky analyze the control flow and instructions used. 

## Reference CPU Testing
This is the 2nd of 2 testing steps.
You should put this processor: https://git.ece.iastate.edu/cpre381course/cpre381-sample-processors/-/tree/master/test_processors/sc_processor
into the 381 toolflow. You can then run the toolflow on all of the tests using 

```bash
./381_tf.sh test path/to/student_tests/*.s
```
and see which ones fail.

You will likely have a lot of tests without halts. You can just add halt to the end then retry.
