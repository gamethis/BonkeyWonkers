# Exercise 6

Back to [Main](../README.md)

This exercise will test your basic skillset with GitHub Actions and Workflows.

## Create GitHub Action/Workflow

### Step 1

Create a GitHub workflow that runs `Once a Week` and checks if [FRR](https://GitHub.com/FRRouting/frr)
has released a new Minor or Patch version of the Major version referenced in the
[Bonkey Containers File](./BonkeyContainers.yaml)

<details>
  <summary>
  Leverage act to test your file locally.
  </summary>

  ```code
    Create your file in the local .github folder
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
docker build -t act-local .
docker tag act-local:latest localhost:5000/act-local:latest
docker image push localhost:5000/act-local:latest
 ```

 </details>
  </p>

### Step 2

Update the GitHub workflow so that the [Bonkey Containers File](./BonkeyContainers.yaml)
updates with the latest Minor patch version of [FRR](https://GitHub.com/FRRouting/frr)
is detected in Step 1.

### Step 3

Update the GitHub workflow to submit a pull request on a new branch to BonkeyWonkers
If Step 2 Updates the file. Provide a good description of what is being updated.

## Exercise 6 complete
