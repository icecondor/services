resource "digitalocean_droplet" "icecondor-api-cc" {
  name               = "icecondor-api-cc"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-18-04-x64"
  region             = "nyc3"
  volume_ids         = ["${digitalocean_volume.geodata.id}"]
  private_networking = true
  ipv6               = true
  monitoring         = true
  ssh_keys           = ["48:7e:89:f4:c6:0c:ed:28:e8:31:16:87:ce:13:30:04"]
  tags               = ["${digitalocean_tag.api.id}", "${digitalocean_tag.web.id}"]
}

resource "digitalocean_volume" "geodata" {
  region      = "nyc3"
  name        = "geodata"
  size        = 50
  description = "icecondor customer data"
}