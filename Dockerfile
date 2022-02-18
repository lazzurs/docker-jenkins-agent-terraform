FROM jenkins/inbound-agent:latest

ARG terraform_version=1.1.6
ARG terragrunt_version=0.36.1

# Switch to root
USER root

# Update system
RUN apt update && apt -y upgrade

# Add the ability to use PPAs
RUN apt -y install gnupg2

# Install useful local utils
RUN apt -y install wget unzip curl jq

# Install Terraform
RUN if [ $(uname -m) = "x86_64" ]; then curl "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip" -o "terraform.zip"; elif [ $(uname -m) = "aarch64" ]; then curl "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_arm64.zip" -o "terraform.zip"; fi
RUN unzip terraform.zip -d /usr/local/bin/

# Install Terragrunt
RUN if [ $(uname -m) = "x86_64" ]; then curl -L -s --output /usr/local/bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/${terragrunt_version}/terragrunt_linux_amd64"; elif [ $(uname -m) = "aarch64" ]; then curl -L -s --output /usr/local/bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/${terragrunt_version}/terragrunt_linux_arm64"; fi

RUN chmod +x /usr/local/bin/terragrunt

# Install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Switch back to the jenkins user.

USER jenkins

