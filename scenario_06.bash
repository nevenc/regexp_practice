#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_where_third_matches_first_or_second
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all rows where the third
number is equal to one of the first numbers from testdata_2.txt

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_2.txt
EOF
}

generate_help_file() {
cat > basic_help.txt <<EOF
 Using character classes
 Matching this or that
 Grouping things and hierarchical matching
 Backreferences
EOF
cat > advanced_help.txt <<EOF
 Regular Expressions - Metacharacters
 Regular Expressions - Quantifiers
EOF
}

check_that_answer_greps_all_where_third_matches_first_or_second() {
    FACIT_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
2,4,2 .    .  ......
2,4,4 .    .  .    .
2,4,2 ......  ......
2,4,2 .    .  .    .
2,4,4 .    .  .    .
EOF
    ACTUAL_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
    grep -P "$(< answer.regex)" testdata_2.txt > ${ACTUAL_FILE} 2> /dev/null
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
