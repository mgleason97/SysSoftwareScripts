#!/bin/sh

# Michael Gleason
# COP 3402 Spring 2019

# ==================
# Parser: test-parser.sh
# ==================
# Run this script from the command line like so:
#
# 	bash test-parser.sh
#
# This script must be in your project folder, and your "syllabus"
# and project folder must be in the same directory.
#
# For example, put "syllabus" and "project-<username>" on the desktop
# and make sure this script is in "project-<username>" folder

################################################################################
# Shell check.
################################################################################

# Running this script with sh instead of bash can lead to false positives on the
# test cases. These checks ensure the script is not being run through the
# Bourne shell (or any shell other than bash).

if [ "$BASH" != "/bin/bash" ]; then
  echo ""
  echo " Please use bash to run this script, like so: bash test-parser.sh"
  echo ""
  exit
fi

if [ -z "$BASH_VERSION" ]; then
  echo ""
  echo " Please use bash to run this script, like so: bash test-parser.sh"
  echo ""
  exit
fi


################################################################################
# Initialization.
################################################################################

PASS_CNT=0
NUM_TEST_CASES=29

# used for right-alignment
col=27


################################################################################
# Compile and run test cases.
################################################################################

echo ""
echo "============================================================================="
echo "Running test cases..."
echo "============================================================================="
echo ""

# Make sure latest edit to file is being used.
make > /dev/null

# Test for every .pl0 extension in the tests directory
for i in ../syllabus/project/tests/*.pl0;
do
	[ -f "$i" ] || break

	# Extract filename from path and print
	filename=$(basename -- "$i")
	printf '  [Test Case] Checking %s...\t' "$filename" | expand -t $col

	# Attempt compilation and check for failure
	./compiler --parse $i > test.txt 2> /dev/null
	compile_val=$?
	if [ $compile_val != 0 ]; then
		echo "fail (failed to compile)"
		continue
	fi

	# Remove extension from filename
	sample_file="${filename%.*}"

	# Run diff and capture return val
	diff test.txt ../syllabus/project/tests/$sample_file.ast > /dev/null
	diff_val=$?
	if [ $diff_val != 0 ]; then
		echo "fail (output mismatch)"
	else
		echo "PASS!"
		PASS_CNT=`expr $PASS_CNT + 1`
	fi
done

# remove test.txt after running all testcases
rm test.txt


################################################################################
# Report.
################################################################################

echo ""
echo "============================================================================="
echo "Final Report"
echo "============================================================================="

if [ $PASS_CNT -eq $NUM_TEST_CASES ]; then
	echo ""
	echo "  CONGRATULATIONS! You appear to be passing all the test cases provided"
	echo "  in the syllabus/project/tests folder!"
	echo ""
	echo "  DISCLAIMER: This script does not guarantee a 100% on your assignment"
	echo "  so please consider further testing and debugging."
	echo ""
else
	echo "                                 ."
	echo "                                \":\""
	echo "                              ___:____     |\"\\/\"|"
	echo "                            ,'        \`.    \\  /"
	echo "                            |  o        \\___/  |"
	echo "                          ~^~^~^~^~^~^~^~^~^~^~^~^~"
	echo ""
	echo "                                 (fail whale)"
	echo ""
	echo "  Looks like you're failing at least one testcase. Keep up the hard work"
	echo "  and refer to syllabus/project/overview.md for instructions."
	echo ""
fi
