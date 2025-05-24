TERRAFORM TASK 3 – Multi-Environment Infrastructure Setup

In this task, we are using Terraform to create and manage infrastructure across different environments: development (dev), testing (test), and production (prod). The project is organized in a modular way, which means different parts of the infrastructure (like EC2, VPC, Subnets, etc.) are separated into reusable components called modules. This approach makes the code more organized, easier to manage, and scalable when more resources or environments are added later.

Folder Structure Overview:

project/ ├── dev/ ├── test/ ├── prod/ └── modules/

Each folder has a specific purpose. The dev, test, and prod folders are used to set up infrastructure specific to that environment. The modules folder contains the actual building blocks that are reused in each environment.

Environment Folder: dev/

The dev folder contains Terraform configuration for the development environment. Here we define how different modules (like VPC, EC2, etc.) are instantiated and configured using environment-specific values.

Key Files in the dev/ folder:

backend.tf: This file is used to configure the remote state backend. Remote state allows storing the Terraform state file (which keeps track of resources created) in a remote location like AWS S3 or Terraform Cloud. This is useful for team collaboration.

local.tf: Defines local variables that are only used within this environment. These variables are not passed externally but used internally to simplify logic.

main.tf: The main configuration file that calls and connects the different modules (like VPC, EC2, Subnet, etc.) together using variables.

output.tf: Defines what information should be shown to the user after applying Terraform. For example, the public IP of the EC2 instance, VPC ID, or subnet ID.

provider.tf: Configures the cloud provider. In this case, AWS. It includes details like the AWS region and credentials.

terraform.tfvars: Contains the actual values for the variables declared in variable.tf. These are specific to the development environment.

variable.tf: Declares the input variables that main.tf needs. For example, CIDR blocks, instance types, availability zones, etc.

This structure helps us manage the infrastructure for development separately without affecting testing or production.

Modules Folder: modules/

This folder contains reusable Terraform modules. Each subfolder represents a module that manages a specific AWS resource or component. These modules can be called in any environment folder (like dev, test, or prod), which helps avoid repeating the same code.

Subfolders inside modules/:

ec2/: This module creates EC2 instances. It uses parameters like AMI ID, instance type, key pair name, subnet ID, and instance tags.

eip/: Manages Elastic IPs. These are static public IP addresses that can be attached to EC2 instances.

igw/: Creates an Internet Gateway, which allows public subnets to access the internet.

nat/: Creates a NAT Gateway. This allows instances in private subnets to access the internet (like for installing packages) without being exposed publicly.

s3/: Sets up S3 buckets. These can be used for storing logs, Terraform state files, or application data.

sg/: Manages security groups and rules. Security groups control what traffic is allowed in or out of EC2 instances or other AWS services.

subnet/: Creates subnets inside a VPC. These can be public or private and are defined using CIDR blocks and availability zones.

vpc/: Creates the Virtual Private Cloud (VPC), which is the core of the AWS networking setup. Other resources like subnets, EC2, and gateways are built inside the VPC.

![Screenshot 2025-05-24 165352](https://github.com/user-attachments/assets/a1b4cd5a-a456-44df-b20e-bb1a9fa863da)

![image](https://github.com/user-attachments/assets/e47f3f28-b4e8-458a-a822-6670e0c52498)

![image](https://github.com/user-attachments/assets/f2771fe9-cb8d-4cbd-92fa-e6ce2337a2f8)


