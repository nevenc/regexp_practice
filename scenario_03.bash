#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_tests_in_sweden
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all tests that where
performed in sweden (4th column) from the file testdata_1.txt.

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
How to express digits.
How to express words.
How to express disjunctions OR Character Classes.
EOF
}

check_that_answer_greps_all_tests_in_sweden() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
1 9 failure sweden 'second capacitor held steady, but beam did not penetrate'
2 7 failure sweden 'beam succeeded to penetrate material, but not evaporate target'
6 8 Success sweden 'fastidious corrosion on the fastening belt'
12 8 succceeded sweden 'results from denmark reproduced'
13 9 failed sweden 'german results reproduced - nothing worked - one of those days'
15 8 Failed sweden 'vaporization initiated but beam not held steady enough'
19 9 failed sweden 'focal point failed to destabilize material bonds - no evaporation'
21 5 failure Sweden 'failed test setup - hardware not properly calibrated'
25 7 success Sweden 'weak fuel cells again - we need them to be more stable'
29 6 failure Sweden 'cabling from emitter to phasetizer caught fire'
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
