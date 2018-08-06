resource "digitalocean_droplet" "icecondor-api-nyc3-aa" {
  lifecycle { 
   prevent_destroy = true
   ignore_changes = "resize_disk"
  }

  ipv6               = "true"
  name               = "mx.icecondor.com"
  size               = "1gb"
  image              = "6918990"                                           #"ubuntu-14-04-x64"
  region             = "nyc3"
  resize_disk        = false
  private_networking = true
  ssh_keys           = ["9d:79:da:b7:00:29:c4:1b:68:06:7d:bd:e2:99:90:42"]
}
