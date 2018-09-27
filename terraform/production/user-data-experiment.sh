curl -X POST "https://api.digitalocean.com/v2/droplets" \
      -d'{"name":"coreos-1","region":"nyc3","size":"512mb","private_networking":true,"image":"coreos-stable","user_data":
"#cloud-config

coreos:
  etcd:
    # generate a new token for each unique cluster from https://discovery.etcd.io/new
    discovery: https://discovery.etcd.io/<token>
    # multi-region deployments, multi-cloud deployments, and droplets without
    # private networking need to use $public_ipv4
    addr: $private_ipv4:4001
    peer-addr: $private_ipv4:7001
  fleet:
    public-ip: $private_ipv4   # used for fleetctl ssh command
  units:
    - name: etcd.service
      command: start
    - name: fleet.service
      command: start",
      "ssh_keys":[ <SSH Key ID(s)> ]}' \
      -H "Authorization: Bearer $TOKEN" \
      -H "Content-Type: application/json"

