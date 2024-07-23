# Exercise 7

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
    cd /workspaces/BonkeyWonkers/exercise7
    docker build -t act-local:latest .
    docker tag act-local:latest localhost:5000/act-local:latest
    docker image push localhost:5000/act-local:latest
    cd /workspaces/BonkeyWonkers
 ```

 </details>
  </p>

## Step 2

Update your workflow to:

- With a Job name/Job-ID of `check`.
- Fetch the latest Released Version of [FRR](https://api.github.com/repos/frrouting/frr/releases).
  This should be constrained to the [Major version](https://semver.org/)
  referenced in [Bonkey Containers File](./BonkeyContainers.yaml).
- Print the version to terminal.

## Exercise 7 complete

Proceed to [Exercise 8](../exercise8/README.md)
