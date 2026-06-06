# Exercise 3: Scripting Challenge 🐍

Back to [Main](../README.md)

**Time limit:** 15 minutes

**Objective:** Master Python and Bash scripting through mathematical
calculations and text processing challenges that demonstrate real-world
automation capabilities.

## Challenge Overview

This exercise tests your ability to create robust, multi-language scripts that
handle mathematical computations and configuration file processing - essential
skills for DevOps automation and system administration.

## Detailed Script Instructions

### Exercise 1: Pythagorean Theorem Calculator

Write a script, using Bash or Python or another language of your choice, with
a function that calculates the hypotenuse of a right triangle, given two sides
as inputs.

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
root@6209920d39aa:/exercises# python3 pythagorean.py 45 10
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

**Task:** Parse `config.json.tmpl`, performing text substitution on the
placeholder variables and save the result to `config.json`.

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

All the tools, commands, and libraries are present to complete the exercises
using `Python` or `bash` or another programming language of your choice.

Complete both of the following exercises:

1. Complete scripting exercise 1 (Pythagorean Calculator)
2. Complete scripting exercise 2 (Configuration Template Processor)

### Deliverable: Pythagorean Theorem Calculator

Write the calculator in the language of your choice. Using the suggested
filenames, it should run like this:

- **Python** — e.g. `pythagorean.py`, using the `math` library:
  `python3 pythagorean.py <side1> <side2>`
- **Bash** — e.g. `pythagorean.sh`, using `bc` for precision:
  `./pythagorean.sh <side1> <side2>`
- **Check:** sides `3 4` should produce `5` (e.g. `5.0`).

### Deliverable: Configuration Template Processor

Write a processor that reads `config.json.tmpl`, substitutes the placeholder
variables, and writes the result to `config.json`.

- **Python** — e.g. `config_processor.py` (file I/O + string replacement)
- **Bash** — e.g. `config_processor.sh` (e.g. `sed` substitution)
- **Result:** a valid `config.json` with every placeholder replaced (matching the
  expected output shown above).

## Exercise 3 Complete

Proceed to [Exercise 4](../exercise4/README.md)
