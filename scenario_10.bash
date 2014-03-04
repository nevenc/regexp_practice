#!/bin/bash

main() {
	if [[ ${1} == "--verify" ]]
	then
	    check_that_answer_greps_all_okay_passwords
	else
	    generate_description_file
	    generate_help_file
	    bash user_text.bash $0
	fi
}

generate_description_file() {
cat > description.txt <<EOF
Write a regular expression that matches all 'passwords' from the
file testdata_6.txt. An alphanumeric sequence is considered as
being a 'password' if it contains 
    * At least one uppercase letter
    * At least one lowercase letter
    * At least one number

Put your regular expression into a file called answer.regex in
the directory where you executed the scenario script.

Your answer will be executed the following way by the system.
             grep -P "\$(< answer.regex)" testdata_6.txt
EOF
}

generate_help_file() {
cat > basic_help.txt <<EOF
 Matching this or that
EOF
cat > advanced_help.txt <<EOF
 Regular Expressions - Metacharacters
EOF
}

check_that_answer_greps_all_okay_passwords() {
    FACIT_FILE=$(mktemp)
    cat > ${FACIT_FILE} <<EOF
aBcdefgh1jklmnop  ..  .....  ..... .......
Abcde7gh1jklmnop   .      .      .       .
abCd3fgh1jklmn0p   .      .      .      .
AbcdEfghijkl9nop   .  .....  .....  ......
abcdefghiklmnoP4   .      .      .    .
abCd3fgh1jklNnop   .      .      .   .
aBCDEFGHIJKLMN0P  ... .....  .....  .     
EOF
    ACTUAL_FILE=$(mktemp)
    grep -P "$(< answer.regex)" testdata_6.txt > ${ACTUAL_FILE} 2> /dev/null
    diff -q ${FACIT_FILE} ${ACTUAL_FILE} &> /dev/null
    if [[ $? == 0 ]]
    then
	RES='Verified - you are done'
    else
	RES='No - you are not done'
    fi
#    rm ${FACIT_FILE} ${ACTUAL_FILE}
    echo ${RES}
}

main $@
