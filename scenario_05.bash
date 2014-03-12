#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_failed_that_mention_fuel_cells
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all failed tests where 
the note (last column) mentions the fuel cells from 
the file testdata_1.txt.

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

check_that_answer_greps_all_failed_that_mention_fuel_cells() {
    FACIT_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
4 7 failure germany 'fuel cells depleeted immediately - must have been old'
8 6 Failure denmark 'spectrometer not calibrated properly - good fuel cells'
9 5 failed denmark 'succeess on beam penetration - fuel cell died shortly after'
17 6 failure denmark 'fuel cell failed during trial - backup successfully started'
EOF
    ACTUAL_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
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
