terraform {
  required_providers {
    proxmox = {
      source  = "registry.example.com/telmate/proxmox"
      version = ">=1.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_api_url		= "https://${var.PROXMOXSERVERIP}:8006/api2/json"
  pm_user			= "root@pam"
  pm_password		= var.SUPERSECRETPASSWORD
  pm_tls_insecure	= "true"
}

variable "PROXMOXSERVERIP" {
  type = string
}

variable "SUPERSECRETPASSWORD" {
  type = string
}

variable "NODETOBEDEPLOYED" {
  type = string
}

variable "INSERTSSHHPUBLICKEYHERE" {
  type = string
}

resource "proxmox_vm_qemu" "k8s_master" {
  count             = 1
  vmid              = "121"
  bios              = "ovmf"
  name              = "k8s-master"
  target_node       = var.NODETOBEDEPLOYED
  clone             = "ubuntu-template"
  agent             = 1
}

resource "proxmox_vm_qemu" "k8s_node" {
  count             = 2
  vmid              = "12${count.index + 2}"
  bios              = "ovmf"
  name              = "k8s-node${count.index + 1}"
  target_node       = var.NODETOBEDEPLOYED
  clone             = "ubuntu-template"
  agent             = 1
}
