CLUSTER_NAME := local

.PHONY: up
.ONESHELL:
up: cluster.yaml render
	@if ! kind get clusters 2>/dev/null | grep '^$(CLUSTER_NAME)$$' >/dev/null; then
		kind create cluster --wait 60s --name $(CLUSTER_NAME) --config $< 
		kubectl apply -f auth.yaml
	fi

.PHONY: render
render: cluster.yaml

cluster.yaml: cluster.yaml.jinja2 ../docker-cache/registries.yaml
	jinja2 $^ >$@

.PHONY: clean
clean:
	kind delete cluster --name $(CLUSTER_NAME)
