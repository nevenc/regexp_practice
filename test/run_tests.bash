#!/bin/bash

DONE="Verified - you are done"
NOT_DONE="No - you are not done"

main() {
   for((x=1;x<=5;x++))
   do
       if [[ ${x} -lt 10 ]]
       then
	   NUM=0${x}
       else
	   NUM=${x}
       fi
       pushd ../ &> /dev/null
       bash scenario_${NUM}.bash &> /dev/null
       test_that_verification_fails_for_scenario ${NUM}
       solution_for_scenario_${NUM}
       test_that_verification_passes_for_scenario ${NUM}
       rm answer.regex &> /dev/null
       rm {description,help}.txt
       popd &> /dev/null
   done
}

solution_for_scenario_01() {
    echo '^\d+ 6 .*' > answer.regex
}

solution_for_scenario_02() {
    echo '^\d+ [89] .*' > answer.regex
}

solution_for_scenario_03() {
    echo '^\d+ \d \w+ [Ss]weden .*' > answer.regex
}

solution_for_scenario_04() {
    echo '^\d+ \d [Ss]\w+ ([Dd]|[Gg]).*' > answer.regex
}

solution_for_scenario_05() {
    echo '^\d+ \d [Ff]a\w+ \w+ .*fuel cell.*' > answer.regex
}

test_that_verification_fails_for_scenario() {
    if [[ $(bash scenario_${1}.bash --verify 2> /dev/null) == ${NOT_DONE} ]]
    then
    	echo "T${1}_neg passed"
    else
    	echo "T${1}_neg failed"
    fi
}

test_that_verification_passes_for_scenario() {
    if [[ $(bash scenario_${1}.bash --verify 2> /dev/null) == ${DONE} ]]
    then
	echo "T${1}_pos passed"
    else
	echo "T${1}_pos failed"
    fi
}

main
