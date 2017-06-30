# minemeld-test
Scripts/playbooks to set up a MineMeld CI/CT infrastructure on AWS

## Architecture
The CI/CT infrastructure is composed by 2 main parts:
1. an EC2 instance running Jenkins
1. one or more EC2 instances to use for the builds

The instances for #2 are dynamically created by Jenkins jobs. The set up script will configure Jenkins with the AWS credentials and SSH keys needed to spin up and communicate with these instances.

## Repo Layout
- **infrastructure/** Directory with infrastructure set up code
- **tests/** Directory with test jobs for Jenkins
- **mm-cict-up.sh** Main script for setting up the infrastructure
- **config.sh.tmpl** Config parameters for mm-cict-up.sh

## How To
- Copy *config.sh.tmpl* to *config.sh* and edit contents
```
$ cp config.sh.tmpl config.sh
$ # edit config.sh contents
```
- Launch the script
```
$ ./mm-cict-up.sh
```
- After the set up you should be able to access Jenkins on port 8080 of the EC2 instance
