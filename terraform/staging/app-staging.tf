resource "digitalocean_droplet" "icecondor-app-staging" {
  name               = "staging.icecondor.com"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-20-04-x64"
  region             = "nyc3"
  private_networking = true
  ipv6               = true
  monitoring         = true
  ssh_keys           = ["48:7e:89:f4:c6:0c:ed:28:e8:31:16:87:ce:13:30:04"] #digitalocean/2018
  tags               = ["api", "web"]

  provisioner "local-exec" {
    command = "../../he_net_dns staging.icecondor.com ${digitalocean_droplet.icecondor-app-staging.ipv4_address}"
  }
  provisioner "local-exec" {
    command = "../../he_net_dns api.staging.icecondor.com ${digitalocean_droplet.icecondor-app-staging.ipv4_address}"
  }
}
