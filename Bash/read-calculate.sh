#!/bin/bash
#Read the input values using read keyword
read X
read Y

#Checking whether Y is 0
if [ $Y -ne 0 ] then
    echo "Addition is $(( $X+$Y ))"
    echo "Subtraction is $(( $X-$Y ))"
    echo "Multiplication is $(( $X*$Y ))"
    echo "Quotient is $(( $X/$Y ))"
    echo "Remainder is $(( $X%$Y ))"
fi