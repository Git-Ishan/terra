Terraform Deployment of an Azure Application Gateway

This project uses Terraform to provision a Standard v2 Azure Application Gateway. The primary goals were to configure SSL termination for secure HTTPS traffic and to set up path-based routing for distributing requests to different backend services.

<img width="600" height="558" alt="1" src="https://github.com/user-attachments/assets/9552a112-3c67-4eef-8066-056dde06a426" />


Architectural Summary

This deployment establishes a high-availability Application Gateway (Standard_v2 SKU with two instances) within the example resource group.

Network Configuration

A virtual network named appgw-vnet is provisioned with a 10.0.0.0/16 address space. It is segmented into a dedicated subnet for the gateway:

AppGatewaySubnet (10.0.1.0/24): Exclusively for the Application Gateway's operations.

<img width="1920" height="1200" alt="2" src="https://github.com/user-attachments/assets/7b06e5f0-8584-4665-8e41-d4bd7d5ddbc4" />


Frontend Configuration and SSL Offloading

A Standard SKU Public IP (appgw-pip) is configured as the gateway's frontend to accept incoming HTTPS traffic. SSL offloading is implemented by an HTTPS listener on port 443, which uses a certificate securely loaded via the filebase64() function. All TLS decryption is handled at the gateway, allowing for unencrypted HTTP communication between the gateway and the backend pools, which improves efficiency.

<img width="637" height="804" alt="3" src="https://github.com/user-attachments/assets/57982029-745e-442c-a14e-a80778e8ab30" />

Path-Based Routing

The Application Gateway is configured to distribute traffic intelligently by inspecting the URL path of incoming requests. Two specific path rules have been established:

Requests for /images/* are directed to the image-pool.

Requests for /videos/* are directed to the video-pool.

If a request's path does not match either of these rules, it is routed to the default backend pool, which is also the image-pool in this configuration
