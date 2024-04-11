# Exercise 1

Back to [Main](../README.md)

## Step 1: Initialize and apply existing TF resources

Init, plan, and apply the current terraform code in this directory.
 This should create 3 separate text files in the current directory.

## Step 2: Move resource from one module to another

Move the `file2` resource from [module 1](../modules/module1/) to
 [module 2](../modules/module2/).  Do this in a way that when you
 run terraform apply again you DO NOT recreate any files or anything.

## Step 3: Run TF Plan and validate no changes

When you re-run your terraform plan, the 3 files should remain untouched
 but we should be able to see that `file2.txt` is now created via module 2.

Expected output:

```bash
terraform apply
module.m2.local_file.file2: Refreshing state... [id=6a23b0a0be4741283159cdf45b6814073415c47c]
module.m1.local_file.file1: Refreshing state... [id=bcaa1563249780a80f62de4264a2347dec98ec48]
module.m2.local_file.file3: Refreshing state... [id=41e5c0166e1d0a452b06bb7341ae669fea1a714b]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against
 your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

```

## Exercise 1 complete

Proceed to [Exercise 2](../exercise2/README.md)
