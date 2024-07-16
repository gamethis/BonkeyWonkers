# Script Instructions

## Exercise 1

Write a script, using Bash or Python, with a function that calculates the hypotenuse
of a right triangle, given two sides as inputs.

The formula is: c = sqrt(a^2 + b^2)

> HINT: if using bash/shell, use the `bc` command to calculate the sqrt.
> <https://www.geeksforgeeks.org/bc-command-linux-examples/>
> Example Bash execution

```shell
> root@6209920d39aa:/exercises# ./pythagorean.sh 45 10
> 46.09772228646443655001
```

> Example Python execution

```shell
> root@6209920d39aa:/exercises# python pythagorean.py 45 10
> 46.09772228646444
```

## Exercise 2

File "config.json.tmpl" contains the following text:

```json
{
    "properties": {
        "build": "_BUILD_NAME_",
        "bucket": "_BUCKET_",
        "project": "_PROJECT_",
        "version": "_VERSION_"
    }
}
```

Parse "config.json.tmpl", performing a text substitution on the placeholder
variables within the template file.
The values should be substituted as below and saved into a file called "config.json".
You can choose to do it in Bash or Python.

config.json

-----------

```json
{
    "properties": {
        "build": "abc1234",
        "bucket": "gcs_mythd_bucket",
        "project": "my_new_project",
        "version": "v1.0"
    }
}
```
