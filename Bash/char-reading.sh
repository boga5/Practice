#!/bin/bash
read -n 1 answer
#echo $answer
if [ "$answer" = "Y" ] || [ "$answer" = "y" ]; then
    echo YES
elif [ "$answer" = "N" ] || [ "$answer" = "n" ]; then
    echo NO
fi