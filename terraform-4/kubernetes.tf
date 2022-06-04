terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "host" {
  type = string
}

variable "client-certificate" {
  type = string
}

variable "client-key" {
  type = string
}

variable "cluster-ca-certificate" {
  type = string
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client-certificate)
  client_key             = base64decode(var.client-key)
  cluster_ca_certificate = base64decode(var.cluster-ca-certificate)
}
