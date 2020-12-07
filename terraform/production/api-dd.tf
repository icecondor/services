resource "digitalocean_droplet" "icecondor-api-dd" {
  name               = "icecondor-api-dd"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-18-04-x64"
  region             = "nyc3"
  volume_ids         = ["${digitalocean_volume.geodata.id}"]
  private_networking = true
  ipv6               = true
  monitoring         = true
  ssh_keys           = ["48:7e:89:f4:c6:0c:ed:28:e8:31:16:87:ce:13:30:04"]
  tags               = ["api", "web"]
}

