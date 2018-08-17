# ansible-hortonworks-configuration

## Motivation
The idea is to clone ansible-hortonworks from GitHub and change the variables without actually changing any of the files cloned.

The repository shows how to override variables in ansible-hortonworks/inventory/aws/group_vars/all and ansible-hortonworks/playbooks/group_vars/all using parameter extra-vars from the command line when running playbooks.


### Make sure awscli is installed

### In /etc/profile.d/sh.local add secret key and access key
export AWS_SECRET_ACCESS_KEY=
export AWS_ACCESS_KEY_ID=

### Clone ansible-hortonworks repository:
git clone https://github.com/hortonworks/ansible-hortonworks.git


### Files in config folder:
- aws-cluster.yml - in eu-west-1, 2 instances are created of type t2.xlarge. Ami is centos 7.
- hdp-cluster-hadoop3.yml - creates an HDP 3.0 cluster based on the variables in this file
- hdp-cluster-minimal.yml - creates an HDP 2.6.5 (default by HDP in GitHub) with minimal services
