# Exercise 3: Scripting Challenge 🐍

Back to [Main](../README.md)

**Objective:** Master Python and Bash scripting through mathematical calculations and text processing challenges that demonstrate real-world automation capabilities.

## Challenge Overview

This exercise tests your ability to create robust, multi-language scripts that handle mathematical computations and configuration file processing - essential skills for DevOps automation and system administration.

## Detailed Script Instructions

### Exercise 1: Pythagorean Theorem Calculator

Write a script, using Bash or Python or another language of your choice, with a function that calculates the hypotenuse of a right triangle, given two sides as inputs.

**Formula:** `c = sqrt(a^2 + b^2)`

**Implementation Hints:**
- **Bash/Shell:** Use the `bc` command to calculate the sqrt ([bc command reference](https://www.geeksforgeeks.org/bc-command-linux-examples/))
- **Python:** Use the `math.sqrt()` function for calculations

**Expected Output Examples:**

Bash execution:
```shell
root@6209920d39aa:/exercises# ./pythagorean.sh 45 10
46.09772228646443655001
```

Python execution:
```shell
root@6209920d39aa:/exercises# python pythagorean.py 45 10
46.09772228646444
```

### Exercise 2: Configuration Template Processor

**Input File:** `config.json.tmpl` contains:
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

**Task:** Parse `config.json.tmpl`, performing text substitution on the placeholder variables and save the result to `config.json`.

**Variable Substitutions:**
- `_BUILD_NAME_` → `abc1234`
- `_BUCKET_` → `gcs_mythd_bucket`
- `_PROJECT_` → `my_new_project`
- `_VERSION_` → `v1.0`

**Expected Output:** `config.json`
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

## Complete Scripting Exercises

All the tools, commands, and libraries are present to complete the exercises using `Python` or `bash` or another programming language of your choice.

You have 15 minutes to complete both of the following exercises:

1. Complete scripting exercise 1 (Pythagorean Calculator)
2. Complete scripting exercise 2 (Configuration Template Processor)

### Exercise 1: Pythagorean Theorem Calculator
- **`pythagorean.py`** - Python implementation with math library
- **`pythagorean.sh`** - Bash implementation using bc for precision
- **Usage:** `python3 pythagorean.py <side1> <side2>` or `./pythagorean.sh <side1> <side2>`
- **Test:** Both versions calculate hypotenuse for sides 3,4 → 5.0

### Exercise 2: Configuration Template Processor
- **`config_processor.py`** - Python template processor with file I/O
- **`config_processor.sh`** - Bash implementation using sed substitution  
- **Usage:** Run scripts in exercise3 directory to process `config.json.tmpl` → `config.json`
- **Result:** Generates valid JSON with all placeholder variables substituted

## Exercise 3 Complete

Proceed to [Exercise 4](../exercise4/README.md)
