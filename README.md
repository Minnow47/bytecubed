# AWS Fargate with Terraform

This repository contains configuration to deploy a Dockerized web server to AWS Fargate using Terraform.

I am making an assumption that you have awscli setup, docker installed, and that you have a profile of terraform and that we are deploying to us-east-1. These are defaults.

** NOTE: If this isn't the case provider_aws.tf will need to be modified for your deployment **

Also you should be able to cut and paste the commands from the document to your terminal. Lines starting with '$' are commands. Do not include the '$' when copy/paste.

To get started, clone the repository and change to terraform directory:

$ git clone https://github.com/Minnow47/bytecubed.git && cd bytecubed/terraform 

We need to create a backend for our Terraform state. We will use S3:

EXAMPLE: 
$ aws s3 mb s3://sd-tfstate --profile=terraform

** NOTE: update vars.tf with your S3 bucket name **

Once you have updated your S3 bucket settings it is time to initialize terraform. Ensure you are in the terraform directory and issue the following command:

$ terraform init

We will be using AWS Elastic Container registry (ECR) to store docker images. In order to apply the whole terraform plan, including container deployment, Docker image has to be first made available. Therefore first create a repository by using partial configuration (--target option). Issue the following command to create our registry:

$ terraform apply --target aws_ecr_repository.myapp  

For simplicity let's just export it to the environment:

$ export REPO_URL=$(terraform output myapp-repo)  

DOCKER -> ECR

So we have this new ECR, now we need to put something in it. Execute the following to login docker to ECR:

$ $(aws ecr get-login --region us-east-1 --no-include-email)

Go up a directory and enter the docker directory, then myapp directory so we can build our container:

$ docker build -t myapp .
$ docker tag myapp ${REPO_URL}:latest
$ docker push ${REPO_URL}:latest

DEPLOYMENT

Now that our container is uploaded to ECR we are ready to deploy the rest of the environment. Change back to our terraform directory and execute.

$ terraform apply

After all changes are applied, you should see a DNS name of an ALB. Just open it in your Web browser to check a greeting message from your container deployed on AWS Fargate.

Outputs:


At some point you will also want to tear everything down you can do this with the following command from the terraform direcotry.

** NOTE: This will also destory our ECR and your docker image along with it. **

$ terrafrom destroy


REFERENCES
Installing awscli
https://docs.aws.amazon.com/cli/latest/userguide/installing.html
https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

Installing Docker
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

Installing Terraform
https://www.terraform.io/intro/getting-started/install.html


