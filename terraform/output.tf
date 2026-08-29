output "vm_public_ip" {
  value       = google_compute_instance.mailrax_vm.network_interface[0].access_config[0].nat_ip
  description = "Your server's public IP address. Copy this directly into your Cloudflare A-Record."
}

output "openship_dashboard_url" {
  value       = "http://${var.target_domain}"
  description = "The exact destination URL to access your self-hosted web control platform setup"
}
