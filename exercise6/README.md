# Exercise 6

Back to [Main](../README.md)

This exercise is meant to test your ability to run basic
 terraform commands and make a modification to a terraform module.

The actual outcome of this exercise is purely to ensure you can run
 basic terraform commands, and a simple test to see if you understand
 templating in terraform.  DON'T OVER THINK IT!

## Step 1 Initialize Workspace

+ Initialize, Plan, and Execute the Terraform configuration
  in the directory to create an initial `HelloWorld.txt`.

  <details>
  <summary>
  HelloWorld.txt contents
  </summary>

    ```Text
    Hello NONAME,

    Welcome to terraform templating!
    Can you list 3 things you like?

    Provide List here:


    - BonkeyWonkers

    ```

  </details>
  </p>

## Step 2 Modify Terraform Module, Update HelloWorld text file

+ Update the Terraform template(`HelloWorld.tftpl`) file so that the resulting `HelloWorld.txt`
  includes 3 things you like, each on a new line.

    > **NOTE:** The purpose of this exercise is to test your knowledge of
                terraform variables and templates.
                To complete this step, you should make use of a list that
                is iterated through using Terraform's
                templating to render the final `HelloWorld.txt`

    Exmample List for user GameThis

    ```text
    Pizza
    Gardening
    Programming
    ```

+ Run `Terraform` again
  <details>
  <summary>
  Expected Output
  </summary>

    ```text
    Hello GameThis,

    Welcome to terraform templating!
    Can you list 3 things you like?

    Provide List here:
    - Pizza
    - Gardening
    - Programming

    - BonkeyWonkers
    ```

  </details>

## Exercise 6 complete
