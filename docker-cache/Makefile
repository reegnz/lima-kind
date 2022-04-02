
all: docker-compose.yaml cluster.yaml

docker-compose.yaml: docker-compose.yaml.jinja2 registries.yaml 
	jinja2 docker-compose.yaml.jinja2 registries.yaml >$@

cluster.yaml: cluster.yaml.jinja2 registries.yaml
	jinja2 cluster.yaml.jinja2 registries.yaml >$@
