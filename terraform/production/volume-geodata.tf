
resource "digitalocean_volume" "geodata" {
  region      = "nyc3"
  name        = "geodata"
  size        = 62
  description = "icecondor geo data"
}
