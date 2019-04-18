#!/bin/sh

# Michael Gleason
# COP 3402 Spring 2019
# Inspired by Sean Szumlanski

# ==================
# TestAll: test-all.sh
# ==================
# Run this script from the command line like so:
#
# 	bash test-all.sh
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
  echo " Please use bash to run this script, like so: bash test-typecheck.sh"
  echo ""
  exit
fi

if [ -z "$BASH_VERSION" ]; then
  echo ""
  echo " Please use bash to run this script, like so: bash test-typecheck.sh"
  echo ""
  exit
fi


################################################################################
# Initialization.
################################################################################

PASS_CNT=0
SCRIPTS=(lexer parser typechecker pcode codegen)
NUM_TEST_CASES=${#SCRIPTS[@]}

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
echo "Running scripts..."
echo "============================================================================="
echo ""

for i in ${SCRIPTS[@]}; do
	printf '  [Script] Running test-%s.sh...\t' "$i" | expand -t $col
	bash test-${i}.sh > /dev/null
	compile_val=$?
	
	if [ $compile_val == 3 ]; then
		echo "fail (make failed)"
		echo ""
		echo " Error: make command was unsuccessful. Execute make for error message."
		echo "        (Aborting script)"
		echo ""
	elif [ $compile_val == 2 ]; then
		echo "fail (misplaced file)"
		echo ""
		echo " Error: test-${i}.sh failed because of a misplaced file. Try running"
		echo "        that script separately. (Aborting)"
		echo ""
		exit
	elif [ $compile_val == 1 ]; then
		echo "fail (run script separately)"
	else 
		echo "PASS!"
		PASS_CNT=`expr $PASS_CNT + 1`
	fi
	
done


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
fi
