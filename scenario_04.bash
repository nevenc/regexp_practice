#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_successfull_tests_in_denmark_and_germany
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all successfull tests
performed (3rd column), which where successfull in the countries
denmark and germany (4th column) from the file testdata_1.txt.

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_1.txt
EOF
}

generate_help_file() {
cat > basic_help.txt <<EOF
 Using character classes
 Matching this or that
EOF
cat > advanced_help.txt <<EOF
 Regular Expressions - Metacharacters
 Regular Expressions - Quantifiers
EOF
}

check_that_answer_greps_all_successfull_tests_in_denmark_and_germany() {
    FACIT_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
3 6 success denmark 'spot on'
7 7 Success germany 'failure in the coolant - but overal test success'
10 6 succeeded denmark 'narrow band emitter failed and burned up shortly after'
14 9 Succeeded germany 'success even though we failed to calibrate emitter diode'
16 7 success germany 'increased fuel cell efficiency allowed for longer trial'
18 7 success denmark 'nothing of interest'
20 8 succeeded germany 'spot on - everything went as planned'
24 5 success Denmark 'beam energy fluctuated wildly - probably due to fuel cell'
26 6 success germany 'all ok'
27 9 Succeeded Germany 'nothing out of the ordinary'
28 8 success Denmark 'new fuel cells give a steady beam output'
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
