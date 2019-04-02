# SysSoftwareScripts
Test scripts for each part of the Systems Software project (UCF COP 3402)

Function and Struct index: [APIs](APIs.md)

## Running testscripts

Place the `scripts` folder inside of your `project-<username>` folder. Your `project-<username>` folder
should also be next to your `syllabus` folder (E.g. place both folders on the desktop).

To run an individual script, open a terminal in the `scripts` folder and run `bash test-<script>.sh`.
For instance, the typechecker can be run with `bash test-typechecker.sh`.

The `test-all.sh` script will run the scripts for the individual assignments and will be updated as the
other scripts are added. 

The `test-err.sh` script can be used to test the [type_error() testing files](https://piazza.com/class/jqidj3mhs91lo?cid=128) uploaded to Piazza. 
The `err` folder should be extracted and placed inside of your `project-<username>` folder to run this script.

The `test-pcode.sh` script will test if vm_impl.c is `implemented` properly. As of now, `fib_frames` expected output files appear to be buggy, so it may show `fail (vmout mismatch)` even though your output is correct. Additionally, `while.pl0` causes an infinite loop so the script simply skips over that case. 

The `test-codegen.sh` script will test **ALL** of the codegen section. If you are just using it to test part 1, expect to see failed testcases. I do not plan on creating a separate case to test for part 1's required functions. 

**NOTE**: If you are using the pre-compiled files from binaries.tar, change the "binaries" value in each test script ("Initialization" section) to 1. When using the binaries, first run make in your project folder then copy over all \*.o files except for the .o corresponding to the project section you are testing. Also, _**DO NOT**_ copy over the compiler file. 

If you come across any bugs, please report them to this repo. 
