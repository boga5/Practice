#!/bin/bash

#input size of array
#echo "Enter the size of array"
read size

#initialize the empty array
array=()
if [ "$size" -ge 1 ] && [ "$size" -le 500 ]; then
    #read values of array ensuring the length doesn't exceed
    for (( i=0; i<size; i++ ));
    do
        #echo "Enter value for element $((i+1)): "
        read value
        if [ "$value" -ge -10000 ] && [ "$value" -le 10000 ]; then
            array+=("$value")
        fi
    done
    
    #print array
    #echo "Array elements are: "
    #for element in "${array[@]}"; 
    #do
    #    echo $element
    #done
    
    #calculate the average of array
    sum=0
    for count in "${array[@]}";
    do
        sum=$((sum + count))
    done
    #echo "Sum is $sum"
    
    #calculate the average
    avg=$(echo "scale=3; $sum / $size" | bc)
    echo $avg
    #printf  "%.3f\n" $((sum / size))
fi