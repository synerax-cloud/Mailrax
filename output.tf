
output "vm_public_ip" {
  value       = google_compute_instance.mailrax_vm.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of the deployed virtual machine"
}