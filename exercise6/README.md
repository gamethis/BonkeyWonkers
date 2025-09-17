# Exercise 6 - Terraform Planning & Templating

Back to [Main](../README.md)

## Overview

This exercise tests your ability to:
- Execute basic Terraform workflow commands
- Modify Terraform modules and templates
- Implement list variables and template iteration
- Use Terraform templating syntax for dynamic content generation

## Available Files

- `main.tf` - Root module that calls the helloworld module
- `providers.tf` - Terraform provider configuration
- `modules/helloworld/` - Module containing template and variable definitions
- `modules/helloworld/templates/HelloWorld.tftpl` - Template file to be modified
- `modules/helloworld/variables.tf` - Variable definitions
- `modules/helloworld/main.tf` - Module output configuration

## Step 1: Initialize and Deploy Initial Configuration

### 1.1 Initialize Terraform
Initialize the Terraform working directory:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: Terraform initializes successfully and downloads required providers.

### 1.2 Plan and Apply Initial Setup
Deploy the initial configuration:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: Creates `HelloWorld.txt` with the following content:

```text
Hello NONAME,

Welcome to terraform templating!
Can you list 3 things you like?

Provide List here:


- BonkeyWonkers
```

## Step 2: Implement Template Enhancement

### 2.1 Analyze Current Structure
Examine the existing module structure and identify what needs to be modified:
- Template file location and current content
- Variable definitions and usage
- Module input/output configuration

### 2.2 Add List Variable Support
Modify the module to support a list of favorite things:

```bash
Edit the appropriate variable definition file
```

**Requirement**: Add a list variable that can hold multiple string values.

### 2.3 Update Template with Iteration
Modify the template to iterate through the list:

```bash
Edit the template file to include list iteration
```

**Requirement**: Use Terraform templating syntax to loop through list items.

### 2.4 Update Module Configuration
Ensure the module can pass the new variable to the template:

```bash
Update module configuration files as needed
```

### 2.5 Provide List Data
Update the root configuration to include your favorite things:

```bash
Modify the root module to pass actual list data
```

**Example List**:
```text
Pizza
Gardening  
Programming
```

## Step 3: Apply and Validate Changes

### 3.1 Plan the Changes
Review the planned modifications:

```bash
Use the terraform Command-Line Interface (CLI)
```

**Expected Result**: Plan shows changes to the HelloWorld.txt content.

### 3.2 Apply the Updated Configuration
Deploy the enhanced template:

```bash
Use the terraform Command-Line Interface (CLI)
```

### 3.3 Verify Output
Check the generated `HelloWorld.txt` file:

**Expected Output** (example for user "GameThis"):
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


### Objectives
By completing this exercise, you will demonstrate:
- Terraform workflow command execution
- Module modification and variable management
- Template function usage and iteration syntax
- Dynamic content generation with complex data types
- Infrastructure-as-code templating best practices

## Exercise 6 Complete

Once all validation steps pass successfully, proceed to [Exercise 7](../exercise7/README.md).
