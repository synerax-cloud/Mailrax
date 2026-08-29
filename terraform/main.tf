# 1. Dedicated isolated VPC Network
resource "google_compute_network" "mailrax_vpc" {
  name                    = "mailrax-vpc"
  auto_create_subnetworks = false
}

# 2. Private Subnetwork allocation
resource "google_compute_subnetwork" "mailrax_subnet" {
  name          = "mailrax-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.mailrax_vpc.id
}

# 3. Global Public Internet Gateway Route
resource "google_compute_route" "mailrax_internet_route" {
  name             = "mailrax-internet-route"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.mailrax_vpc.id
  next_hop_gateway = "default-internet-gateway"
}

# 4. Global Network Firewall rules
resource "google_compute_firewall" "openship_firewall" {
  name    = "openship-firewall"
  network = google_compute_network.mailrax_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"] # Secure SSH Access Keys
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"] # Essential Web Traffic & SSL Handshakes
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["openship-server"]
}

# 5. Virtual Machine Instance with Automation Bootstrap
resource "google_compute_instance" "mailrax_vm" {
  name         = var.vm_name
  machine_type = "e2-medium" # Baseline recommendation for stable builds
  zone         = var.gcp_zone

  tags = ["openship-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30 # Expanded storage footprint to accommodate Docker images
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.mailrax_subnet.id
    access_config {} # Dynamic Public IP assignments
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand(var.public_key_path))}"
  }

  
}
