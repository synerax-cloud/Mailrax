# 1. Create a brand new, dedicated VPC network
resource "google_compute_network" "mailrax_vpc" {
  name                    = "mailrax-vpc"
  auto_create_subnetworks = false
}

# 2. Create a safe, private subnet inside that VPC
resource "google_compute_subnetwork" "mailrax_subnet" {
  name          = "mailrax-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.mailrax_vpc.id
}

# 3. Update your VM to use the new custom subnet
resource "google_compute_instance" "mailrax_vm" {
  name         = var.vm_name
  machine_type = "e2-medium"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    # LINK TO THE NEW SUBNET HERE
    subnetwork = google_compute_subnetwork.mailrax_subnet.id

    # Keeps direct outbound internet access alive for downloading packages
    access_config {} 
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand(var.public_key_path))}"
  }
}

# 4. Update your Firewall rule to use the new custom VPC
resource "google_compute_firewall" "openship_firewall" {
  name    = "openship-firewall"
  # LINK TO THE NEW VPC HERE
  network = google_compute_network.mailrax_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"] # Keeps SSH port open for your keys
  }
    allow {
    protocol = "tcp"
    ports    = ["80", "443", "3001"] 
  }

  # Allows traffic from any source IP (or restrict this to your IP for safety)
  source_ranges = ["0.0.0.0/0"] 
}


