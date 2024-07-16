# Exercise 6

Back to [Main](../README.md)

This exercise will test your basic skillset with GitHub Actions and Workflows,
and scripting abilities.

## Create GitHub Action/Workflow

### Step 1

Create a GitHub workflow named `Bonkey-Check.yaml` that runs `Once a Week` and
exits successfully if the [Bonkey Containers File](./BonkeyContainers.yaml) is present.

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

## Step 2

Update your workflow to:

- With a Job name/Job-ID of `frr_check`.
- Fetch the latest Version of [FRR](https://GitHub.com/FRRouting/frr).
  This should be constrained to the [Major version](https://semver.org/)
  referenced in [Bonkey Containers File](./BonkeyContainers.yaml).
- Print the version to terminal.
- Save the Output to a variable called `frr_version` that will be
  refrenced in future jobs.

## Exercise 6 complete

Proceed to [Exercise 7](../exercise7/README.md)
