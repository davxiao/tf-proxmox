# tf-proxmox

This sample code stands up one k8s master and two k8s nodes using Terraform proxmox module.

## Install proxmox module for terraform

It is a community support module. Not officially supported by terraform.

```
git clone https://github.com/Telmate/terraform-provider-proxmox.git
cd terraform-provider-proxmox
go install github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provider-proxmox
go install github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provisioner-proxmox
make
### plugin installation for terraform v0.13 and up
PLUGIN_ARCH=darwin_amd64
mkdir -p ~/.terraform.d/plugins/registry.example.com/telmate/proxmox/1.0.0/$PLUGIN_ARCH
cp bin/terraform-provider-proxmox ~/.terraform.d/plugins/registry.example.com/telmate/proxmox/1.0.0/$PLUGIN_ARCH/
cp bin/terraform-provisioner-proxmox ~/.terraform.d/plugins/registry.example.com/telmate/proxmox/1.0.0/$PLUGIN_ARCH/
```

## export environ variables for your TF code

All TF variables must use this naming convention: Having prefix `TF_VAR_` followed by the var name you use in your TF code.

```
export TF_VAR_PROXMOXSERVERIP=your-proxmox-server-ip-here
export TF_VAR_SUPERSECRETPASSWORD=your-password-here
export TF_VAR_INSERTSSHHPUBLICKEYHERE="your-openssh-public-key-here"
### if you don't have your public key handy but have your openssh private key, you can extract the public key using the following:
### export TF_VAR_INSERTSSHHPUBLICKEYHERE=`ssh-keygen -y -f your-private-key-filename-here`
export TF_VAR_NODETOBEDEPLOYED=your-proxmox-node-name-found-on-the-webconsole-like-pve
```

## edit main.tf

Update `main.tf` in this repo and make changes accordingly.

## Terraform time

Assuming you have terraform v0.13 or up installed already, run:

```
terraform plan
terraform apply
```

If you need to see verbose output from terraform for troubleshooting, run `export TF_LOG=TRACE` ; when you no longer need it, disable it with `export TF_LOG=`

