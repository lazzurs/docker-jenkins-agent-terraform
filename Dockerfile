FROM jenkins/inbound-agent:latest

ARG terraform_version=0.12.29

# Switch to root
USER root

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip
RUN unzip terraform_${terraform_version}_linux_amd64.zip -d /usr/local/bin/

# Switch back to the jenkins user.

USER jenkins

