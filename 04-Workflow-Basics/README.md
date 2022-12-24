# Terraform Workflow Basics

The core Terraform workflow works in four ordered steps: 
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
- ```terraform destroy```

## Terraform init
```terraform init```

Initializes your Terraform directory. Run whenever pulling recent changes from source control, or starting a new Terraform project.

Always run ```terraform init``` for the following usecases:
1. Creating a new Terraform project
2. Pulling in any recent changes from Github
3. After making any changes to remote Modules and Providers (like changing the Provider version)

```terraform init -upgrade``` Run when making any changes to your Provider version
- Updates the .terraform folder and the lock file
- Downloads a new Provider based on changes

## Terraform Plan
```terraform plan```

Compares what you have defined in code to what is out there in the real world. Terraform provides you with a detailed output of proposed changes, but the changes will not be applied - a dry-run.   

Command is usually ran before an apply, to see the proposed effects of your changes before you permenantly apply them.

Default behavior is to compare

