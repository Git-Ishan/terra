Terraform Project: Setting Up VPC, Subnet, and EC2 Instance This Terraform project is designed to automate the process of creating a basic AWS infrastructure. It includes the setup of a Virtual Private Cloud (VPC), a subnet within that VPC, and an EC2 instance. The project follows a modular approach, meaning each part of the infrastructure (VPC, Subnet, EC2) is built using its own separate module. This makes the project more organized, reusable, and easier to maintain.

The entire setup is divided into three main modules:

EC2 Module This module handles the creation of the EC2 instance.
Files in the EC2 module:

main.tf – This is where the EC2 instance is actually defined. It specifies things like the AMI ID (Ubuntu), instance type (t3.micro), the subnet where the instance should be launched, and tags like the name of the instance.

variables.tf – Contains input variables such as:

ami (Amazon Machine Image ID),

instance_type (like t3.micro),

subnet_id (to specify which subnet to use),

name (for tagging the instance).

outputs.tf – After the EC2 instance is created, this file is used to display important information such as the Instance ID.

VPC Module This module is responsible for creating a Virtual Private Cloud (VPC), which acts like a private network in AWS.
Files in the VPC module:

main.tf – Defines the VPC resource using values like the CIDR block (e.g., 10.0.0.0/16) and name tag.

variables.tf – Declares the variables required to create the VPC, such as:

cidr_block (the IP address range for the VPC),

name (to label the VPC).

outputs.tf – Outputs the VPC ID once the resource is created so that it can be used in other modules.

Subnet Module This module creates a subnet within the VPC created above.
Files in the Subnet module:

main.tf – Creates a subnet and associates it with the VPC using a smaller CIDR block and an availability zone.

variables.tf – Input values required here include:

vpc_id

cidr_block

availability_zone

outputs.tf – Displays the Subnet ID once it's created.

Root Module Setup The root module is the main entry point of the project. It ties all the above modules together.

Files in the root module:

main.tf – This is where all the individual modules (VPC, subnet, EC2) are called and their variables are passed in. It acts like the "control center" for the infrastructure.

variables.tf – Declares the input variables that will be used across all modules.

terraform.tfvars – Contains the actual values for the variables declared above (like CIDR blocks, instance type, etc.).

outputs.tf – Displays the final output after all resources are created. This includes:

VPC ID Subnet ID EC2 Instance ID

![image](https://github.com/user-attachments/assets/9d71c7b4-24e7-48ac-90d9-46fad45f0055)

![image](https://github.com/user-attachments/assets/138dee4a-9a72-45bb-9283-02142e0001a1)

