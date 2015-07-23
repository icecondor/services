resource "digitalocean_droplet" "icecondor-sql-nyc3-aa" {
  name = "icecondor-sql-nyc3-aa"
  size = "512mb"
  image = "ubuntu-14-04-x64"
  region = "nyc3"
  private_networking = true
  ssh_keys = ["9d:79:da:b7:00:29:c4:1b:68:06:7d:bd:e2:99:90:42"]
}
