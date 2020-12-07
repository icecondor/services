
resource "digitalocean_volume" "geodata" {
  region      = "nyc3"
  name        = "volume-nyc3-03"
  size        = 61
}
