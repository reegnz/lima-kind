INSTANCE_NAME := docker

.PHONY: up
up: docker.yaml
	./bin/vm.sh ensure_vm $(INSTANCE_NAME) $<

.PHONY: stop
stop:
	./bin/vm.sh stop_vm $(INSTANCE_NAME)

.PHONY: clean
clean:
	./bin/vm.sh clean_vm $(INSTANCE_NAME)
