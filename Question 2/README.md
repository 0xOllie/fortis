# Question 2: AWS Network with Terraform

## Infrastructure

This AWS infrastructure was deployed in my personal account so I could test the network accessibility of each component.
For the application server I added a Cloud-init script to install nginx, so that the Application load balancer and target group could be tested.

In the GIF below you can see a terminal capture of me logging into the Bastion host, then the Application server and finally connecting to the RDS instance.

![Demo GIF](./documentation/demo.gif)

## Design Decisions

For this project I decided to modify the original infrastructure requirements to make the project easier to test, this section details the decisions and rationale for each modification.

| Decision         | Rationale                                                                                                                                                                 |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| HTTP for ALB     | Using HTTPS for this test would require additional resources, such as a Route53 Zone and an ACM Certificate. I decided to use HTTP so I could test networking with Nginx. |
| VPC Module       | Instead of creating a bespoke VPC module I used the publicly available one as the design did not require more advanced configurations.                                    |
| RDS Module       | Similar rationale for this too, without detailed capacity requirements, a placeholder is sufficient.                                                                      |
| State Management | I did not provision a remote Terraform state primarily so this code could be tested easily. For production instances I always use remote state with S3 as a backend.      |
| SSH Key          | I did not provision and manage the SSH key for this test. I generally do not think it is a good practice for Terraform state to store raw secrets in state.               |
