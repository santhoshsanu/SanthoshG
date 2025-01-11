## For Loop Syntax

```
#!/bin/bash

for n in a b c;
do
   echo $n
done

```
### explaination: This initializes a for loop where n is the loop variable.



##########################################################################################


#!/bin/bash
echo "Directory path entered by user is /home/ubuntu/contents/*"
for path in "$(!!)";
do
    echo "processing ${path} "
    if [ -d "$path" ];
    then
        echo "${path} is directory"
    elif [ -f "$path" ];
    then
        echo "$path is file"
    fi
done