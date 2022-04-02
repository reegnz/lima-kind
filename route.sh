#!/usr/bin/env bash
#
# This script establishes a route into the docker network of kind clusters running in a lima-vm
# 
# It sets up a route on MacOS to route the docker network IP-s into the lima host.
# It also sets up an iptables forward rule on the docker host to forward 
# incoming traffic on the lima0 interface into the bridge interface of the 
# docker subnet.

set -euo pipefail
set -x

HOST_IF=lima0
HOST_LIMA_IP=$(ifconfig bridge100 | awk '/inet /{print $2}')
GUEST_INTERFACES="$(limactl shell docker -- ip -o -4 a s)"
GUEST_LIMA_IP="$(<<<"${GUEST_INTERFACES}" awk '/lima0/{print $4}' | awk -F/ '{print $1}')"
KIND_IF="$(<<<"${GUEST_INTERFACES}" awk '$2 ~ /br-/{print $2}')"
KIND_NET="$(<<<"${GUEST_INTERFACES}" awk '$2 ~ /br-/{print $4}')"


subnets() {
  limactl shell docker -- \
    docker network ls --filter 'driver=bridge' -q |
  xargs -L 1 limactl shell docker -- \
    docker network inspect --format '{{range .IPAM.Config}}{{.Subnet}}{{end}}'
}

# check with netstat -nr
sudo route -nv add -net "${KIND_NET}" "${GUEST_LIMA_IP}"
limactl shell docker -- \
	sudo iptables -t filter -A FORWARD -4 -p tcp \
	-i "${HOST_IF}" -s "${HOST_LIMA_IP}" -d "${KIND_NET}" \
	-j ACCEPT -o "${KIND_IF}"
limactl shell docker -- sudo iptables -L
