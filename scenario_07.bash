#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_that_does_not_repeat_number_three_times
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all rows where at least
one of the numbers differs from the others in testdata_3.txt

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_1.txt
EOF
}

generate_help_file() {
cat > help.txt <<EOF
Character Classes and Other Special Escapes
Capture Groups
Extended patterns - Look-Around Assertions
EOF
}

check_that_answer_greps_all_that_does_not_repeat_number_three_times() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
1,2,1 ..... ...... ...... ...... .....  .....  .......
3,3,1 .     .    . .    . .    . .      .         .
4,7,1 .     .    . .....  .....  .....  .         .
8,4,3 .     .    . .   .  .   .  .      .         .
0,2,1 ..... ...... .    . .    . .....  .....     .
EOF
    ACTUAL_FILE=$(mktemp)
    grep -P "$(< answer.regex)" testdata_3.txt > ${ACTUAL_FILE} 2> /dev/null
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
