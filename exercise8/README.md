# Exercise 8

Back to [Main](../README.md)

This exercise will test your basic skillset with GitHub Actions and Workflows.
The focus of this exercise is working with a file and the local GitHub Repo.

## Create GitHub Action/Workflow

### Step 1

Create/Update a GitHub workflow in the file named `Bonkey-Check.yaml`,
to update the [Bonkey Containers File](./BonkeyContainers.yaml) with the Version
of the enviornment variable `version`.
This should leverage a job name/job id of `update`.
Cat the file to demonstrate the change

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
    cd /workspaces/BonkeyWonkers/exercise8
    docker build -t act-local:latest .
    docker tag act-local:latest localhost:5000/act-local:latest
    docker image push localhost:5000/act-local:latest
    cd /workspaces/BonkeyWonkers
 ```

 </details>
  </p>

## Exercise 8 complete

Proceed to [Exercise 9](../exercise9/README.md)
