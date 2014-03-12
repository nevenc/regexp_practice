#!/bin/bash

cat <<EOF
=================================================================
EOF
cat description.txt
cat <<EOF
=================================================================
PerlTut                    http://perldoc.perl.org/perlretut.html
$(< basic_help.txt)

PerlRe                        http://perldoc.perl.org/perlre.html 
$(< advanced_help.txt)
EOF
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
