#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

vm_exists() {
  limactl list -f '{{ .Name }}' | grep "${INSTANCE_NAME}" >/dev/null
}

vm_running() {
  limactl list -f '{{ .Name }} {{.Status}}' |
    awk -v instance="${INSTANCE_NAME}" '$1 == instance && $2 == "Running"' |
    grep . >/dev/null
}

create_vm() {
  [[ -n "${LIMA_CONFIG_FILE}" ]] || { echo "Need to specify lima config yaml."; exit 1; }
  limactl start --tty=false --name "${INSTANCE_NAME}" "${LIMA_CONFIG_FILE}"
  limactl stop "${INSTANCE_NAME}"
  limactl start "${INSTANCE_NAME}"
}

set_docker_context() {
  DIR="$(limactl list docker -f '{{.Dir}}')"
  DOCKER_SOCKET="${DIR}/sock/docker.sock"
  docker context rm -f "lima-${INSTANCE_NAME}" || true
  docker context create "lima-${INSTANCE_NAME}" --docker "host=unix://${DOCKER_SOCKET}"
  docker context use "lima-${INSTANCE_NAME}"
}

stop_vm() {
  if vm_running; then
    limactl stop "${INSTANCE_NAME}"
  fi
}

clean_vm() {
  if vm_exists; then
    limactl stop "${INSTANCE_NAME}"
    limactl delete "${INSTANCE_NAME}"
  fi
}

ensure_vm() {
  if ! vm_exists; then
    create_vm
    set_docker_context
  fi
  if ! vm_running; then
    limactl start "${INSTANCE_NAME}"
  fi
}

main() {
  OP=$1
  INSTANCE_NAME=$2
  LIMA_CONFIG_FILE=${3:-}

  $OP
}

main "$@"
