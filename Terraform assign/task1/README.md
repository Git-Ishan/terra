Setting Up an AWS EC2 Instance Using Terraform
This guide explains how to launch a virtual machine (EC2 instance) on AWS using Terraform. The setup uses variables for flexibility, but you can hardcode values if needed.

Configuration Overview
Here’s what we’re setting up:
EC2 Instance Type: t3.micro
Operating System: Ubuntu (defined through an AMI ID)
Subnet: Custom (modifiable)
Public IP: Not assigned
Root EBS Volume Size: Set to 12 GB

Step 1: Install the Required Tools
Open the terminal and enter:
sudo apt update
sudo apt install awscli -y
aws --version

To install Terraform on Windows:
choco install terraform

Step 2: Set Up AWS CLI
After installing AWS CLI, run:
aws configure
You’ll be prompted to provide:
AWS Access Key
AWS Secret Access Key

Log in to the AWS Management Console.
Click your name in the top-right corner and select "My Security Credentials".
Scroll to Access Keys and choose "Create New Access Key".
You can either copy the keys or download them as a .csv file.

Step 3: Set Up Your Project Files
Your Terraform project should contain these files:
provider.tf - Configures AWS provider and credentials
main.tf - Contains the EC2 instance setup
variables.tf - Declares input variables used in configuration
terraform.tfvars - Provides actual values for the variables

Step 4: Run Terraform Commands
Once your files are set, use the following in order:
terraform init - Initializes the Terraform directory
terraform plan - Previews changes Terraform will make
terraform apply -auto-approve - Applies the configuration
terraform destroy -auto-approve - Removes all created resources
![image](https://github.com/user-attachments/assets/fe59151d-0ecf-4ac7-bc2a-51f4ebaea00b)

![image](https://github.com/user-attachments/assets/9380fa3f-0cb8-461a-9fa0-9a68640c07d9)

