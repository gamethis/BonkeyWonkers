# Exercise 9

Back to [Main](../README.md)

This exercise will test your basic skillset with GitHub Actions and Workflows.
The focus of this exercise is to tie workflow jobs together and pass variables
from one job to another.
This exercise will update the work done in
[Exercise 7](../exercise6/README.md) and
[Exercise 8](../exercise7/README.md)

## Create GitHub Action/Workflow

### Step 1

Create/Update a GitHub workflow in the file named `Bonkey-Check.yaml`,
Pass the variable `version` that is an output of `check`
to `update` job.

- Save the output to a variable called `version` in `check` job.
- leverage output variable called `version` in `update` job.

<details>
  <summary>
  Leverage act to test your file locally.
  </summary>

  ```code
    Create your file in the .github folder
    cd /workspaces/BonkeyWonkers
    act -l
    act -j name_of_job
 ```

 </details>
  </p>

<details>
  <summary>
  Add dependencies in to act container if needed
  </summary>

  ```code
    cd /workspaces/BonkeyWonkers/exercise9
    docker build -t act-local:Latest .
    docker tag act-local:latest localhost:5000/act-local:latest
    docker image push localhost:5000/act-local:latest
    cd /workspaces/BonkeyWonkers
 ```

 </details>
  </p>

### Step 2

demonstrate that the `version` from `check` is used in `update`

## Exercise 9 complete
