variable "gcp_project_id" {
  type        = string
  default     = "your-actual-gcp-project-id" # <-- REPLACE WITH YOUR GCP PROJECT ID
}

variable "gcp_region" {
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  type        = string
  default     = "standalone-internet-vm"
}

variable "ssh_user" {
  type        = string
  default     = "ubuntu" # Your preferred SSH login username
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/gcp_vm_key.pub" # Local path to the public key you generated
}
