#!/bin/bash

firstNum=0
secondNum=0
operand=''

# shellcheck disable=SC2034
serialPort1=/dev/pts/4

# state 0
# function for state 0
function state0 {

    firstNum=0
    secondNum=0
    operand=''

    while read -r line; do
      if [[ $line =~ [0-9] ]]; then
        foo=$(echo "$line" | tail -n 1)
        firstNum=$((firstNum+foo))
        echo "firstNum: $firstNum" > "$serialPort1"
        break
      fi
    done < "$serialPort1"

    state1
    exit 0
}


# state 1
# read last line from /dev/pts/2 and if it contains '+' or '-' character then save it to operand variable
function state1 {

    while read -r line; do
      if [[ $line =~ [+-=] ]]; then
        operand=$(echo "$line" | tail -n 1)
        echo "operand: $operand" > "$serialPort1"
        break
      fi
    done < "$serialPort1"

    if [[ $line =~ [=] ]]; then
        echo "result is: $firstNum" > "$serialPort1"
        state0 # restart the cycle
    fi

    state2
    exit 0
}

# state 2
# read last line from /dev/pts/2 and if it contains any number in character from 0 to 9 then save it to secondNum variable
function state2 {
   while read -r line; do
      if [[ $line =~ [0-9] ]]; then
        secondNum=$(echo "$line" | tail -n 1)
        echo "secondNum: $secondNum" > "$serialPort1"
        break
      fi
    done < "$serialPort1"

  state3
  exit 0
}

# state 3
# depending on the operand type numbers either get substracted or added
function state3 {

  if [[ $operand == '+' ]]; then
    firstNum=$((firstNum + secondNum))
  elif [[ $operand == '-' ]]; then
    firstNum=$((firstNum - secondNum))
  fi
  secondNum=0
  state1 # go back to state 1 and load another operand then another value to be either added or substracted
}

# start the automat
state0

exit 0

#while read -r line; do
#  # $line is the line read, do something with it
#  # which produces $result
#  echo "$line" > "$serialPort1"
#done < "$serialPort1"



