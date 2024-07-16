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
Pass the variable `frr_version` that was in the output of `frr_check`
to `frr_update` job.

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
cd /workspaces/BonkeyWonkers/exercise6
docker build -t act-local .
docker tag act-local:latest localhost:5000/act-local:latest
docker image push localhost:5000/act-local:latest
cd /workspaces/BonkeyWonkers
 ```

 </details>
  </p>

### Step 2

demonstrate that the `frr_version` from `frr_check` is used in `frr_update`

## Exercise 9 complete
