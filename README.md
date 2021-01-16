# modusboxtask

# Task description !


As infrastructure and cloud engineer I need to create a tool to create the vms, to install k3s, to deploy a web app and to install/configure haproxy exposing the webapp through http

You can use the Cloud Provider most suitable to you, latest version of terraform, ansible and RKE k3s


# Prerequisite
OS : Ubuntu 18.04

1. Terraform (v0.14.4 and above)
2. kubectl
3. ansible (ansible 2.9.16 and above)


# Preaparing infra and installing application 

Navigate to the modusboxtask folder and execute following command 

ansible-playbook infra.yaml

above command will execute the ansible playbook.

Playbook contain three steps 

1. Provisionaing Azure kubernetes service 
2. Installing ingress gateway 
3. intalling sample app
