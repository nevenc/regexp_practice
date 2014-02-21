#!/bin/bash

cat <<EOF
=================================================================
EOF
cat description.txt
cat <<EOF
=================================================================
Regex cheat sheet        http://tinyurl.com/regex-cheat-sheet-mit

EOF
cat help.txt
cat <<EOF
=================================================================
Run this script as
       bash $1 --verify
when you think you are done
=================================================================
You can always read 
    description.txt To know what you need to do
    help.txt        To get tips and pointers
=================================================================
EOF
