# Exercise 3 - Scripting Challenge

Back to [Main](../README.md)

**Time limit:** 10 minutes

**Objective:** Demonstrate Python and Bash scripting through a math calculation
and a config-templating task — the everyday automation skills behind DevOps and
system administration.

Use `Python`, `bash`, or another language of your choice; all required tools and
libraries are pre-installed. Complete both parts below. Run your scripts from the
`exercise3` directory.

## Part 1: Pythagorean Theorem Calculator

Write a script with a function that calculates the hypotenuse of a right
triangle, given the two sides as inputs.

**Formula:** `c = sqrt(a^2 + b^2)`

**Hints:**

- **Bash/Shell:** use `bc` for the square root
  ([bc reference](https://www.geeksforgeeks.org/bc-command-linux-examples/)) —
  note `bc -l` (or setting `scale=`) is required for decimal precision.
- **Python:** use `math.sqrt()`.

**Suggested filenames & usage:**

- Python — `pythagorean.py`: `python3 pythagorean.py <side1> <side2>`
- Bash — `pythagorean.sh`: `./pythagorean.sh <side1> <side2>`

**Expected output** (sides `45 10`):

```text
$ ./pythagorean.sh 45 10
46.09772228646443655001

$ python3 pythagorean.py 45 10
46.09772228646444
```

Quick check: sides `3 4` should produce `5` (e.g. `5.0`).

## Part 2: Configuration Template Processor

Read `config.json.tmpl`, substitute the placeholder variables, and write the
result to `config.json`.

**Input — `config.json.tmpl`:**

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

**Substitutions:**

- `_BUILD_NAME_` → `abc1234`
- `_BUCKET_` → `gcs_mythd_bucket`
- `_PROJECT_` → `my_new_project`
- `_VERSION_` → `v1.0`

**Suggested filenames:**

- Python — `config_processor.py` (file I/O + string replacement)
- Bash — `config_processor.sh` (e.g. `sed` substitution)

**Expected output — `config.json`:**

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

## Exercise 3 Complete

Proceed to [Exercise 4](../exercise4/README.md).
