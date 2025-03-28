#! /bin/bash

# ECHO COMMAND
echo Hello World!

# VARIABLES
# Uppercase by convention
# Letters, numbers, underscores
NAME="Bob"
echo "My name is $NAME"
echo "My name is ${NAME}"

# USER INPUT
read -p "Enter your name: " NAME
echo "Hello $NAME, nice to meet you!"

# SIMPLE IF STATEMENT
if [ "$NAME" == "Brad" ]
then
  echo "Your name is Brad"
fi

# IF-ELSE
if [ "$NAME" == "Brad" ]
then
  echo "Your name is Brad"
else 
  echo "Your name is NOT Brad"
fi

# ELSE-IF (elif)
if [ "$NAME" == "Brad" ]
then
  echo "Your name is Brad"
elif [ "$NAME" == "Jack" ]
then  
  echo "Your name is Jack"
else 
  echo "Your name is NOT Brad or Jack"
fi

# STRING COMPARISON []
NUM1=31
NUM2=5
if [ "$NUM1" -gt "$NUM2" ]
then
  echo "$NUM1 is greater than $NUM2"
else
  echo "$NUM1 is less than $NUM2"
fi

######## For string comparisons only
# val1 -eq val2 Returns true if the values are equal
# val1 -ne val2 Returns true if the values are not equal
# val1 -gt val2 Returns true if val1 is greater than val2
# val1 -ge val2 Returns true if val1 is greater than or equal to val2
# val1 -lt val2 Returns true if val1 is less than val2
# val1 -le val2 Returns true if val1 is less than or equal to val2
########

# Numerical Comparisons (())
# you can use >, <, <=, >= , !=
if (( NUM1 > NUM2 )); then
    echo "x is greater than y"
fi

# FILE CONDITIONS
FILE="test.txt"
if [ -e "$FILE" ]
then
  echo "$FILE exists"
else
  echo "$FILE does NOT exist"
fi

########
# -d file   True if the file is a directory
# -e file   True if the file exists (note that this is not particularly portable, thus -f is generally used)
# -f file   True if the provided string is a file
# -r file   True if the file is readable
# -s file   True if the file has a non-zero size
# -w    True if the file is writable
# -x    True if the file is an executable

# -u    True if the user id is set on a file
# -g file   True if the group id is set on a file
########

#CASE STATEMENT
read -p "Are you 21 or over? Y/N " ANSWER
case "$ANSWER" in 
  ([yY] | [yY][eE][sS]) # case             
    echo "You can have a beer :)"
    ;; # break                              
  ([nN] | [nN][oO]) # case
    echo "Sorry, no drinking"
    ;; # break
  (*) # default                                
    echo "Please enter y/yes or n/no"
    ;; # break
esac

# SIMPLE FOR LOOP
NAMES="Brad Kevin Alice Mark"
for NAME in $NAMES
  do
    echo "Hello $NAME"
done

# FOR LOOP TO RENAME FILES
FILES=$(ls *.txt)
NEW="new"
for FILE in $FILES  
  do
    echo "Renaming $FILE to new-$FILE"
    mv $FILE $NEW-$FILE
done

# WHILE LOOP - READ THROUGH A FILE LINE BY LINE
LINE=1
while read -r CURRENT_LINE
  do
    echo "$LINE: $CURRENT_LINE"
    ((LINE++))
done < "./new-1.txt"

# FUNCTION
function sayHello() {
  echo "Hello World"
}
sayHello

# FUNCTION WITH PARAMS
function greet() {
  echo "Hello, I am $1 and I am $2"
}

greet "Brad" "36"


# Variable to check exit status of previously executed code
echo $?

# CREATE FOLDER AND WRITE TO A FILE
mkdir hello
touch "hello/world.txt"
echo "Hello World" >> "hello/world.txt"
echo "Created hello/world.txt"


# [] vs (()) 
# String comparison []
# Cannot use >, <, <=, >= , !=
# Use -gt, -lt, -le, -ge, -ne
if [ "$str1" = "$str2" ]; then
    echo "Equal"
fi

# Numerical Comparisons (())
# you can use >, <, <=, >= , !=
x=5
y=3
if (( x > y )); then
    echo "x is greater than y"
fi
