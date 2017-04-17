# Wordpress Template

This cloudformation template creates a wordpress host. It is based from the AWS sample template. It utilises
[AWS Elastic File System](https://aws.amazon.com/efs/) for persistent storage so your changes are saved in
case of EBS failure.

This is an experimental repository. There are valid concerns around EFS performance. It causes t2.micro
instances to become unresponsive, causing ASG to terminate and re-provision the instance about once a day.

## Prerequisites
You will need:
* Docker
* AWS region being deployed to expects 3 AZs
* The following environment variables need to be set when executing the `deploy.sh` script:

```
export AWS_DEFAULT_REGION=default-region
export AWS_ACCESS_KEY_ID=aws-access-key
export AWS_SECRET_ACCESS_KEY=aws-secret-key

export WORD_PRESS_STACK_NAME=stack-name-for-cloudformation
export EC2_KEY_PAIR=ec2-key-pair
export DB_PASSWORD=rds-password
export HOSTED_ZONE_NAME=www.yourwebsite.com
```

# Limitations:
* Cannot scale out beyond 1 instance, however you have the option to scale up the instance size.
* AWS region being deployed to expects 3 AZs.
* Relies on EFS and thus region must support EFS (Elastic File System)

# Features:
* Wordpress persisted via EFS
* Creates a public route 53 entry (You will need to configure the DNS to point to the name servers)
* Autoscaling group of 1