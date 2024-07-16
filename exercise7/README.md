# Exercise 7

Back to [Main](../README.md)

This exercise will test your basic skillset with GitHub Actions and Workflows.
The focus of this exercise is working with a file and the local GitHub Repo.

## Create GitHub Action/Workflow

### Step 1

Create/Update a GitHub workflow in the file named `Bonkey-Check.yaml`,
to update the [Bonkey Containers File](./BonkeyContainers.yaml) with the Version
of the enviornment variable `frr_version`.
This should leverage a job name/job id of `frr_update`.

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

If the File Updates create a Pull request to gamethis/BonkeyWonkers.
Provide the title `Updating Frr Version to keep current with Major version`
Provide a description of what the version is being updated to.

### Step 3

Update the GitHub workflow to submit a pull request on a new branch to BonkeyWonkers
If Step 2 Updates the file. Provide a good description of what is being updated.

## Exercise 7 complete

Proceed to [Exercise 8](../exercise8/README.md)
