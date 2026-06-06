# Exercise 8 - GitHub Actions: File Updates

Back to [Main](../README.md)

**Time limit:** 10 minutes

This exercise will test your basic skillset with GitHub Actions and Workflows.
The focus of this exercise is working with a file and the local GitHub Repo.

## Create GitHub Action/Workflow

### Step 1

Create/Update a GitHub workflow in the file named `Bonkey-Check.yaml`
that updates the [Bonkey Containers File](./BonkeyContainers.yaml) with the
value of the environment variable `version` (define `version` yourself as a
workflow-level `env` variable for this exercise).
This should leverage a job name/job id of `update`.
Cat the file to demonstrate the change.

<details>
  <summary>
  Leverage act to test your file locally.
  </summary>

  ```text
    Create your file in the .github/workflows folder
    cd /workspaces/BonkeyWonkers
    act -l
    act -j name_of_job
 ```

 </details>

<details>
  <summary>
  Add dependencies in to act container if needed
  </summary>

  ```text
    cd /workspaces/BonkeyWonkers/exercise8
    docker build -t act-local:latest .
    docker tag act-local:latest localhost:5000/act-local:latest
    docker image push localhost:5000/act-local:latest
    cd /workspaces/BonkeyWonkers
 ```

 </details>

## Exercise 8 Complete

Proceed to [Exercise 9](../exercise9/README.md).
