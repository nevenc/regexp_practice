#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_8_or_9_o_clock_tests
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all tests that started
at either 9 or 8 in the morning (second column) from the file 
testdata_1.txt.

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_1.txt
EOF
}

generate_help_file() {
cat > basic_help.txt <<EOF
 Using character classes
EOF
cat > advanced_help.txt <<EOF
 Regular Expressions - Metacharacters
 Regular Expressions - Quantifiers
EOF
}

check_that_answer_greps_all_8_or_9_o_clock_tests() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
1 9 failure sweden 'second capacitor held steady, but beam did not penetrate'
5 9 Failure denmark 'insect on targeting lens - exterminator booked for cleanup'
6 8 Success sweden 'fastidious corrosion on the fastening belt'
12 8 succceeded sweden 'results from denmark reproduced'
13 9 failed sweden 'german results reproduced - nothing worked - one of those days'
14 9 Succeeded germany 'success even though we failed to calibrate emitter diode'
15 8 Failed sweden 'vaporization initiated but beam not held steady enough'
19 9 failed sweden 'focal point failed to destabilize material bonds - no evaporation'
20 8 succeeded germany 'spot on - everything went as planned'
23 8 fail denmark 'fastening belt snapped'
27 9 Succeeded Germany 'nothing out of the ordinary'
28 8 success Denmark 'new fuel cells give a steady beam output'
30 8 Failed denmark 'we don't know why'
EOF
    ACTUAL_FILE=$(mktemp)
    grep -P "$(< answer.regex)" testdata_1.txt > ${ACTUAL_FILE} 2> /dev/null
    diff -q ${FACIT_FILE} ${ACTUAL_FILE}  &> /dev/null
    if [[ $? == 0 ]]
    then
	RES='Verified - you are done'
    else
	RES='No - you are not done'
    fi
    rm ${FACIT_FILE} ${ACTUAL_FILE}
    echo ${RES}
}

main $@
