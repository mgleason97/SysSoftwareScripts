#!/bin/sh

# Michael Gleason
# COP 3402 Spring 2019
# Inspired by Sean Szumlanski

# ==================
# pcode: test-pcode.sh
# ==================
# Run this script from the command line like so:
#
# 	bash test-pcode.sh
#
# This script must be in your project folder, and your "syllabus"
# and project folder must be in the same directory.
#
# For example, put "syllabus" and "project-<username>" on the desktop and
# make sure this script is in the "project-<username>" folder

################################################################################
# Shell check.
################################################################################

# Running this script with sh instead of bash can lead to false positives on the
# test cases. These checks ensure the script is not being run through the
# Bourne shell (or any shell other than bash).

if [ "$BASH" != "/bin/bash" ]; then
  echo ""
  echo " Please use bash to run this script, like so: bash test-pcode.sh"
  echo ""
  exit
fi

if [ -z "$BASH_VERSION" ]; then
  echo ""
  echo " Please use bash to run this script, like so: bash test-pcode.sh"
  echo ""
  exit
fi


################################################################################
# Initialization.
################################################################################

PASS_CNT=0
NUM_TEST_CASES=29
binaries=0

# used for right-alignment
col=27


################################################################################
# Check that all required files are present.
################################################################################

if [ ! -f ../Makefile ]; then
	echo ""
	echo " Error: You seem to be in the wrong directory. Make sure the script"
	echo "        folder is in your \"project-<username>\" directory."
	echo "        (Aborting script)"
	echo ""
	exit 2
elif [ ! -d ../../syllabus ]; then
	echo ""
	echo " Error: You must place your \"project-<username>\" and syllabus directories"
	echo "        in the same directory before we can proceed. (Aborting script)"
	echo ""
	exit 2
elif [ ! -d ../../syllabus/project ]; then
	echo ""
	echo " Error: Your project folder is not in your syllabus folder. Why would"
	echo "        you move such sensitive things? SHAME! (Aborting script)"
	echo ""
	exit 2
elif [ ! -d ../../syllabus/project/tests ]; then
	echo ""
	echo " Error: Your tests folder is not in your project folder. Why would"
	echo "        you move such sensitive things? SHAME! (Aborting script)"
	echo ""
	exit 2
fi

################################################################################
# Compile and run test cases.
################################################################################

echo ""
echo "============================================================================="
echo "Running test cases..."
echo "============================================================================="
echo ""

# Make sure latest edit to file is being used.
if [ $binaries == 0 ]; then
	cd .. && make > /dev/null 2> /dev/null
	make_res=$?
	cd scripts
	
	if [ $make_res != 0 ]; then
		echo ""
		echo " Error: make command was unsuccessful. Execute make for error message."
		echo "        (Aborting script)"
		echo ""
		exit 3
	fi
fi

# Test for every .pl0 extension in the tests directory
for i in ../../syllabus/project/tests/*.pl0;
do
	[ -f "$i" ] || break

	# Extract filename from path and print
	filename=$(basename -- "${i%.*}")
	printf '  [Test Case] Checking %s...\t' "$filename" | expand -t $col
	
	# Skip over case that gives infinite loop
	if [ $filename == "while" ]; then
		echo "PASS! (freebie)"
		PASS_CNT=`expr $PASS_CNT + 1`
		continue
	fi
	
	# Remove extension from path
	sample_file="${i%.*}"

	
	### Compile .pl0 into pcode ###

	../compiler $i > test.pcode 2> test.err
	compile_val=$?
	
	# Catch if error in parser or typechecker
	diff test.err $sample_file.ast > /dev/null
	ast_err=$?
	
	diff test.err $sample_file.types > /dev/null
	types_err=$?
	
	if [ $ast_err == 0 ] || [ $types_err == 0 ]; then
		echo "PASS! (caught error)"
		PASS_CNT=`expr $PASS_CNT + 1`
		continue
	elif [ $compile_val != 0 ]; then
		echo "fail (could not compile)"
		continue
	fi
	
	# Fail if pcode is not what's expected
	diff test.pcode $sample_file.pcode > /dev/null
	pcode_diff=$?
	if [ $pcode_diff != 0 ]; then
		echo "fail (pcode mismatch)"
		continue
	fi
	
	
	### Run VM with the pcode as input ###
	
	# Pipe in vmin if applicable
	if [ -f $sample_file.vmin ]; then
		../vm test.pcode < $sample_file.vmin > test.vmout 2> test.vmtrace
		vm_val=$?
	else
		../vm test.pcode > test.vmout 2> test.vmtrace
		vm_val=$?
	fi
	
	if [ $vm_val != 0 ]; then
		echo "fail (vm failed)"
		continue
	fi
	
	# Test for vmout and vmtrace mismatch
	diff test.vmout $sample_file.vmout > /dev/null
	vmout_diff=$?
	
	if [ $vmout_diff != 0 ]; then
		echo "fail (vmout mismatch)"
		continue
	fi
	
	diff test.vmtrace $sample_file.vmtrace > /dev/null
	vmtrace_diff=$?
	
	if [ $vmtrace_diff != 0 ]; then
		echo "fail (vmtrace mismatch)"
		continue
	fi
	
	# All outputs are good if we reach here
	echo "PASS!"
	PASS_CNT=`expr $PASS_CNT + 1`
	
done

# Remove test files
rm test.*


################################################################################
# Report.
################################################################################

echo ""
echo "============================================================================="
echo "Final Report"
echo "============================================================================="

if [ $PASS_CNT -eq $NUM_TEST_CASES ]; then
	echo ""
	echo "                       ,"
	echo "                       \\\`-._           __"
	echo "                        \\\\  \`-..____,.'  \`."
	echo "                         :\`.         /    \\\`."
	echo "                         :  )       :      : \\"
	echo "                          ;'        '   ;  |  :"
	echo "                          )..      .. .:.\`.;  :"
	echo "                         /::...  .:::...   \` ;"
	echo "                         ; _ '    __        /:\\"
	echo "                         \`:o>   /\\o_>      ;:. \`."
	echo "                        \`-\`.__ ;   __..--- /:.   \\"
	echo "                        === \\_/   ;=====_.':.     ;"
	echo "                         ,/'\`--'...\`--....        ;"
	echo "                              ;                    ;"
	echo "                            .'                      ;"
	echo "                          .'                        ;"
	echo "                        .'     ..     ,      .       ;"
	echo "                       :       ::..  /      ;::.     |"
	echo "                      /      \`.;::.  |       ;:..    ;"
	echo "                     :         |:.   :       ;:.    ;"
	echo "                     :         ::     ;:..   |.    ;"
	echo "                      :       :;      :::....|     |"
	echo "                      /\\     ,/ \\      ;:::::;     ;"
	echo "                    .:. \\:..|    :     ; '.--|     ;"
	echo "                   ::.  :''  \`-.,,;     ;'   ;     ;"
	echo "                .-'. _.'\\      / \`;      \\,__:      \\"
	echo "                \`---'    \`----'   ;      /    \\,.,,,/"
	echo "                                   \`----\`"
	echo ""
	echo "                                 (suspicious cat)"
	echo ""
	echo "  CONGRATULATIONS! You appear to be passing all the test cases provided"
	echo "  in the syllabus/project/tests folder! Your success has aroused the"
	echo "  suspicious cat. The suspicious cat accepts the fact that your code"
	echo "  passes these cases, but is still doubtful it works for all scenarios."
	echo "  Maybe you should run some extra test cases in a meager attempt to"
	echo "  please the suspicious cat."
	echo ""
	echo "  DISCLAIMER: This script does not guarantee a 100% on your assignment"
	echo "  so please consider further testing and debugging."
	echo ""
	echo "  REMINDER: Remember to push your code to github once you are satisfied"
	echo "  with your changes."
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
	echo "  Looks like you're failing at least one testcase. Compile an"
	echo "  individual test case to get more granular details about what"
	echo "  is going wrong. Instructions for compilation can be found in"
	echo "  the overview.md file. Keep up the hard work!"
	echo ""
	exit 1
fi
