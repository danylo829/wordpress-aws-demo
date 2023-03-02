# WordPress AWS Demo

This repository contains the Terraform and Ansible configuration to deploy a WordPress on AWS. The Terraform configuration creates the necessary AWS infrastructure, including EC2 instances, a VPC, a subnets, RDS, and an S3 bucket to store the Terraform state file. The Ansible configuration installs and configures WordPress in docker on the created instances.

## Prerequisites

- AWS account
- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- IAM user with appropriate permissions to create AWS resources.

## Getting Started

1. Clone this repository to your local machine.

    ### Configuring the Infrastructure

    Before deploying the infrastructure, configure the Terraform variables. Create `/terraform/terraform.tfvars` file with following content:
    ```
    region           = "<your_region>"
    ssh_pub_key_path = "<your_pub_key_path>"
    rds_name         = "<db_name>"
    rds_username     = "<db_user>"
    rds_password     = "<db_user_pass>"
    ```

    The variables you will need to set are:
    - `region` - the AWS region where the infrastructure will be deployed
    - `ssh_pub_key_path` - the path to the public key that will be used to connect to the EC2 instance
    - `rds_name` - the name of the RDS instance
    - `rds_username` - the username for the RDS instance
    - `rds_password` - the password for the RDS instance

    And export your AWS credentials as environment variables by running the following commands:
    ``` bash
    export AWS_ACCESS_KEY_ID=<your-access-key>
    export AWS_SECRET_ACCESS_KEY=<your-secret-key>
    ```

2. Create an S3 bucket:
    ```bash
    cd terraform/bucket
    terraform init
    terraform apply
    ```

3. Deploy the infrastructure:
    ```bash
    cd ../
    terraform init -backend-config=backend.conf
    terraform apply
    ```

4. Run the Ansible playbook to deploy WordPress by running the following command:
    ```bash
    cd ../ansible
    ansible-playbook -i inventory/hosts playbook.yml --private-key=<path-to-ssh-private-key>
    ```
## Accessing the Wordpress Application

Once the deployment is complete, you can access the Wordpress application by navigating to the public URL that was output by the Terraform script.

To view the output variables, run the following command from the `terraform/` directory:
``` bash
terraform output
```

The output include a variable named `lb_dns_name` that contains the URL of the Wordpress application.

Navigate to this URL in your web browser to access the Wordpress application.

## Cleanup

To delete created infrastructure and resources, run the following command:
``` bash
cd terraform/
terraform destroy
```
