#!/bin/bash
echo hii


number=5
##  we should use paranthesis while adding numbers.
echo $(( $number + 1 )) 


############################# 
`posotional arguments`

name=$1
location=$2
echo "hii $name , welcome to  $location "

#### interactive script
read -p "45th president of us victory or defeat " status
read -p "what is his name " name
echo "hello, $name has $status in the elections"
ubuntu@ip-172-31-8-167:~/script$



################################

* From script1 lets call script2 and try to see if the variable defined in script1 is available for use in script2
* lets execute script1.sh

```bash
#!/bin/bash   ## script1.sh

name="Learning Thoughts"
echo "This is from script 1 name= ${name}"
export name
./script2.sh
```


```bash
#!/bin/bash   ##  script2.sh

echo "This is script2"
echo "Value of name is ${name}"
```
#########################################

* Lets understand how to control visibility of entered text, If we request for sensitive content like 
   pin/password etc, its not a good approach to show the text while user is typing, Shell gives an option of hiding text when the user is typing. 
* This can be achieved by adding a -s option to read command.

```bash
read -p -s "enter your pin " pin
```

########################################


```bash
read -n3 -p "do you want to continue? " reply
```

`Explanation`

`-n3` Reads only the first 3 characters of input.
`-p` Prompts the user with the given text before accepting input.
`-z` flag in shell scripting is used  to check if a string is null or empty. 
reply: Stores the input (up to 3 characters) in the variable reply.
Input provided: yes

Only the first 3 characters (yes) are stored in reply.



##########################################

```bash
${var^^}: Converts to uppercase.
${var,,}: Converts to lowercase.
```


##############################################

#!/bin/bash

# We need three arguments, so checking if the arguments passed count
# is 3 or not

if [[ $# -ne 3 ]]; then
    echo "Incorrect number of arguments passed"
    echo "Usage: ./createfile.sh <directory-name> <file-name> <file-content>"
    exit 1
fi

# create parameters with argument values
directory_name=$1
file_name=$2
file_content=$3

# check if the directory exists, if it doesnot exist create directory

if [[ ! -d ${directory_name} ]]; then
    mkdir ${directory_name} || { echo "Cannot create directory"; exit 1; }
fi

# lets create absolute file path
abs_file_path=${directory_name}/${file_name}

# Try to create a file if the file doesnot exist
if [[ ! -f ${abs_file_path} ]]; then
    touch ${abs_file_path} || { echo "Cannot create a file"; exit 1; }
fi

# Since file is created or present add the contents to it
echo ${file_content} > ${abs_file_path}



`Explaination`

* `$#` : count of number of arguments passed

######################################################3