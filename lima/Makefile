INSTANCE_NAME := docker

.PHONY: up
.ONESHELL:
up: docker.yaml
	@if ! limactl list -f '{{ .Name }}' | grep '^$(INSTANCE_NAME)$$' >/dev/null; then
		limactl start --tty=false --name $(INSTANCE_NAME) $<
		limactl stop $(INSTANCE_NAME)
		limactl start $(INSTANCE_NAME)
	fi

.PHONY: clean
.ONESHELL:
clean:
	@if limactl list -f '{{ .Name }}' | grep '^$(INSTANCE_NAME)$$' >/dev/null; then
		limactl stop -f $(INSTANCE_NAME)
		limactl delete -f $(INSTANCE_NAME)
	fi
