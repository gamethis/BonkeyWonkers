# Exercise 1 - Terraform State Management

Back to [Main](../README.md)

## Overview

This exercise tests your ability to:
- Initialize and apply Terraform configurations
- Manage Terraform state across multiple modules
- Perform resource migration between modules without data loss
- Validate infrastructure changes and state consistency

## Available Files

- `main.tf` - Root module that calls two child modules
- `providers.tf` - Terraform provider configuration
- `../modules/module1/` - Contains resources for file1 and file2
- `../modules/module2/` - Contains resource for file3

## Step 1: Initialize and Apply Infrastructure

### 1.1 Initialize Terraform
Initialize the Terraform working directory:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: Terraform initializes successfully and downloads required providers.

### 1.2 Plan Infrastructure
Review the planned infrastructure changes:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: Plan shows 3 local_file resources to be created.

### 1.3 Apply Configuration
Deploy the infrastructure:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: Three text files are created in the current directory:
- `file1.txt` - Created by module1
- `file2.txt` - Created by module1  
- `file3.txt` - Created by module2

## Step 2: Resource Migration Challenge

### 2.1 Analyze Current State
Examine the current resource structure and identify which resource needs to be moved.

**Task**: Move the `file2` resource from [module1](../modules/module1/) to [module2](../modules/module2/).

**Critical Requirement**: The migration must NOT recreate any files or destroy existing resources.

### 2.2 Plan Migration Strategy
Consider the following approaches:
- Terraform state manipulation commands
- Resource import/export workflows
- Module restructuring techniques

### 2.3 Execute Migration
Implement your chosen migration strategy:

```bash
Use appropriate terraform and state management commands
```

**Expected Result**: Resource is moved between modules without any file recreation or data loss.

## Step 3: Validation and Verification

### 3.1 Verify State Consistency
Run a plan to ensure no unintended changes:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: No changes should be detected.

### 3.2 Validate Resource Ownership
Confirm that `file2.txt` is now managed by module2:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Output**:
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

### 3.3 File Integrity Check
Verify all three files still exist and contain their original content:
- `file1.txt` should contain: "Yo ho ho, I'm File 1"
- `file2.txt` should contain: "Well Hello There, I'm File 2"
- `file3.txt` should contain: "I'm the best file, I'm File 3"

### Objectives
By completing this exercise, you will demonstrate:
- Terraform initialization and deployment workflows
- Advanced state management techniques
- Resource migration strategies
- Infrastructure validation and testing
- Module organization and dependency management

## Exercise 1 Complete

Once all validation steps pass successfully, proceed to [Exercise 2](../exercise2/README.md).
