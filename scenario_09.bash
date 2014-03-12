#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_matching
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all rows where there is
a number followed by either 1 or 3, and then as many repetitions 
of that number as the number following it, or, a letter, followed
by either 2 or 4, and then as many repetitions of that letter as
the number following it, from the file testdata_5.txt

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_5.txt
EOF
}

generate_help_file() {
cat > basic_help.txt <<EOF
 Matching this or that
 Grouping things and hierarchical matching
 Named backreferences
 Matching repetitions
EOF
cat > advanced_help.txt <<EOF
 Regular Expressions - Metacharacters
EOF
}

check_that_answer_greps_all_matching() {
    FACIT_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
    cat > ${FACIT_FILE} <<EOF
124eillka2aaaall .   . ..... .     .       ....   ....  .   . .....
aabc773223222aal .   . .     .     .       .   . .    . ..  . .
aabcei717bceillk . . . ..... .     .       .   . .    . . . . .....
abcellb4bbbbabcl . . . .     .     .       .   . .    . .  .. .
aaeill03000ab1el  . .  ..... ..... .....   ....   ....  .   . .....
EOF
    ACTUAL_FILE=$(mktemp /tmp/REGEXPRACTICE_XXXXXXXX)
    grep -P "$(< answer.regex)" testdata_5.txt > ${ACTUAL_FILE} 2> /dev/null
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
