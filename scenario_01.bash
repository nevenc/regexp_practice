#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_6_o_clock_tests
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all tests that started
at 6 in the morning (second column) from the file testdata_1.txt.

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
How to express digits.
EOF
}

check_that_answer_greps_all_6_o_clock_tests() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
3 6 success denmark 'spot on'
8 6 Failure denmark 'spectrometer not calibrated properly - good fuel cells'
10 6 succeeded denmark 'narrow band emitter failed and burned up shortly after'
17 6 failure denmark 'fuel cell failed during trial - backup successfully started'
26 6 success germany 'all ok'
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
