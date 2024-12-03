#!/bin/bash





echo "enter choice: "
echo "1.addition " 
echo "2.substarction "
echo "3.multiplication "
echo "4.division "
read choice

read -p "enter first number: " num1 
read -p "enter second number: " num2

if [ "$choice" -eq 1 ]; then
  echo "Result= $((num1 + num2))"

elif [ "$choice" -eq 2 ]; then
  echo "Results=  $((num1 - num2))"

elif [ "$choice" -eq 3 ]; then
  echo "Results=  $((num1 * num2))"

elif [ "$choice" -eq 4 ]; then
   if [ "$num2" -ne 0 ]; then
  echo "Results=  $((num1 / num2))"
  else
    echo "Error: Division by zero is not allowed."
    fi


else
  echo "Invalid choice. Please enter a number between 1 and 4."
fi
