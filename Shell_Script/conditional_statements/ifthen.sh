* The basic idea is to test for a condition (IF), and if that condition is true, we do something (THEN) and 
  if condition is false we return failure exit codes (exit)


* example


```bash
#!/bin/bash

FILE=/tmp/random.txt

# Check if the file exits

if [[ -f ${FILE} ]]; then
   cat ${FILE}
   exit 0
fi

exit 1
```


`Explaination:`

* The -f flag specifically checks for the existence of a regular file.
* The -d flag specifically checks for the existence if it is a directory.



* -z	Checks if a string is empty	[[ -z $string ]]
* -d	Checks if a path is a directory	[[ -d $dir_path ]]
* $# provides the count of arguments passed to the script or function.


######################################


