This project sets up a multi-tier application on AWS using Terraform. The goal is to make sure the app is secure, scalable, and always available. The design uses separate pieces (called modules), so it's easy to manage and change when needed.

What This Project Does

It builds the full setup for a basic web app that runs on AWS. The setup includes:

A private network (called a VPC) to keep things safe

Public and private zones (subnets) for organizing resources

Gateways to manage internet access and secure internal communication

Security rules (security groups) to control who can talk to what

Groups of servers that automatically adjust based on traffic (Auto Scaling Groups)

Load balancers to share the traffic

A database stored safely in private zones

Folder Structure

The project is organized like this:

Main folder has general settings and files

A "modules" folder holds different parts:

vpc: for network setup

networking: for gateways and routes

security: for firewall rules

compute: for server setup

alb: for load balancers

rds: for the database

Each module has its own settings, inputs, and outputs.

What Each Module Does

VPC Module:
Makes a private network and creates public/private subnets in each zone. Shares the IDs of those subnets so other parts can use them.

Networking Module:
Sets up internet and NAT gateways, links them with subnets, and manages traffic routes.

Security Module:
Creates rules to control access:

Web servers can be reached via HTTP/HTTPS

App servers accept traffic from web servers

Database only accepts traffic from app servers

Compute Module:
Creates templates for launching web and app servers. These servers automatically scale up or down. It also sets up groups (target groups) for sending traffic.

ALB Module:
Builds one load balancer for the web tier (public) and one for the app tier (private). Sets up traffic rules and connects to the right server groups.

RDS Module:
Creates the database setup, picks the engine and version, sets login info, and places it safely in private zones.

Main Configuration Files

main.tf:
This is the heart of the setup. It connects all modules and shares needed information between them.

variables.tf:
Lists all the things you can change (like AWS region, instance size, etc.)

outputs.tf:
Lists the final things Terraform will show after setup (like database address, load balancer URLs)

terraform.tfvars:
Where you put values for the things you want to customize. It's like filling in a form.

providers.tf:
Tells Terraform to use AWS and mentions the version. Also sets up remote state if needed.

How To Use It

Run terraform init to start the setup

Fill in terraform.tfvars with your values

For secret stuff like database password, it's better to use an environment variable like:
export TF_VAR_db_password="your-password"

Run terraform plan to see what will be created

Run terraform apply to build everything

After it's done, Terraform will show the URLs and other important info

Tips and Best Practices

Keep each part as its own module for easier updates

Never put passwords directly in files — use environment variables or secret managers

Store the Terraform state file safely, like in AWS S3

Keep databases private and control who can access what

Tag all resources so you can track cost and usage

Example Outputs

When the setup finishes, you’ll get things like:

Web load balancer URL

App load balancer URL

Database endpoint

You’ll use these to access your app and connect to the database.

If Something Goes Wrong

If Terraform asks for a value, make sure it’s listed in your variable files

If a module fails, check if all needed inputs were passed

If AWS settings seem off, check the region and credentials


<img width="860" alt="t1" src="https://github.com/user-attachments/assets/60aa8410-6e4d-4291-ad10-686d8e187d28" />

<img width="888" alt="t2" src="https://github.com/user-attachments/assets/5df08707-44c8-44d0-9844-5af28bb4a9a3" />

<img width="897" alt="t3" src="https://github.com/user-attachments/assets/172cbefa-bb72-48b1-a16e-520a7a42a3b3" />

<img width="920" alt="t4" src="https://github.com/user-attachments/assets/fbf9792f-03e5-4f28-a26e-18aac60bd12d" />

