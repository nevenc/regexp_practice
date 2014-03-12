#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_that_has_a_tripple
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all rows where there is
a tripple repetition of something, like aaa from testdata_4.txt

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_4.txt
EOF
}

generate_help_file() {
cat > basic_help.txt <<EOF
 Matching this or that
 Grouping things and hierarchical matching
 Backreferences
 Matching repetitions
EOF
cat > advanced_help.txt <<EOF
 Regular Expressions - Metacharacters
EOF
}

check_that_answer_greps_all_that_has_a_tripple() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
234723478aaa121bb .   .  .....  .....  .....
23477723478a121bb ..  .    .    .      .
23472344478a121bb . . .    .    .      .....
2234723478a121bbb .  ..    .    .      .
234723478a11121bb .   .  .....  .....  .....
EOF
    ACTUAL_FILE=$(mktemp)
    grep -P "$(< answer.regex)" testdata_4.txt > ${ACTUAL_FILE} 2> /dev/null
    diff -q ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
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
