# Exercise 3

Back to [Main](../README.md)

This exercise is meant to test your basic abilities at problem solving by scripting.

## Setup scripting environment

1. Launch the container named `hello` with an interactive `/bin/bash` shell.

 You should see something like:

      ```shell
        root@c0700134dc42:/exercises#
      ```

### Get instructions

1. View the README.md file found in `/exercises` folder.

### Complete Scripting exercises

All the tools, commands, and libraries are present to complete the
exercises using `Python` or `bash`` inside the container.

Alternatively you may install depencies to complete with language of
your choice but time is limited.

You have 15 minutes to complete both of the following exercises.

1. Complete scripting exercise 1.
1. Complete scripting exercise 2.

## Exercise 3 complete

Proceed to [Exercise 4](../exercise4/README.md)


#!/bin/bash

a=$1
b=$2

num1=$((echo "$a^2"|bc))
num1=$((echo "$b^2"|bc))

num=$((num1 + num2))

echo $num

### Exercise 1

Write a script, using Bash or Python, with a function that calculates the hypotenuse of a right triangle, given two sides as inputs.  

The formula is: c = sqrt(a^2 + b^2)

> HINT: if using bash/shell, use the `bc` command to calculate the sqrt.
> https://www.geeksforgeeks.org/bc-command-linux-examples/


> Example Bash execution
```
> root@6209920d39aa:/exercises# ./pythagorean.sh 45 10
> 46.09772228646443655001
```

> Example Python execution
```
> root@6209920d39aa:/exercises# python pythagorean.py 45 10
> 46.09772228646444
```

### Exercise 2

File "config.json.tmpl" contains the following text:
```
{
    "properties": {
        "build": "_BUILD_NAME_",
        "bucket": "_BUCKET_",
        "project": "_PROJECT_",
        "version": "_VERSION_"
    } 
}
```

Parse "config.json.tmpl", performing a text substitution on the placeholder variables within the template file.  The values should be substituted as below and saved into a file called "config.json".  You can choose to do it in Bash or Python.

config.json
-----------
```
{
    "properties": {
        "build": "abc1234",
        "bucket": "gcs_mythd_bucket",
        "project": "my_new_project",
        "version": "v1.0"
    } 
}