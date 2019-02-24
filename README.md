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

If you come across any bugs, please report them to this repo. 
