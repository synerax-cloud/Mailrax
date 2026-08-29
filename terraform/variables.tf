variable "gcp_region" {
  type        = string
  default     = "us-central1"
  description = "Target deployment region"
}
variable "gcp_project_id" {
  type        = string
  default     = "your-actual-gcp-project-id" # <-- REPLACE WITH YOUR GCP PROJECT ID
}

variable "gcp_zone" {
  type        = string
  default     = "us-central1-a"
  description = "Target evaluation zone placement"
}

variable "vm_name" {
  type        = string
  default     = "mailrax-server"
  description = "Compute deployment instance label"
}

variable "ssh_user" {
  type        = string
  default     = "ubuntu"
  description = "The target login terminal context username profile"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "The workspace deployment entry point SSH public verification file key path"
}

variable "target_domain" {
  type        = string
  default     = "openship.mailrax.synerax.in"
  description = "The public target subdomain assigned to navigate down your dashboard panel"
}
