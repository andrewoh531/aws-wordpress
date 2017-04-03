# Wordpress Template

This cloudformation template creates a wordpress host. It is based from the AWS sample template.

# Limitations:
* Cannot scale out beyond 1 instance. You can scale up the instance size.
* Hardcoded to a particular availability zone (ap-southeast-2a). This is to attach an EBS volume used to store the Wordpress files as persistent storage.

# Features:
* Wordpress files backed by EBS volume
* Will automatically attach the EBS volume when ec2 instance provisioned through userdata scripts
* Will create a symlink to an EBS volume for persistence