.PHONY: up
up: render
	docker-compose up -d

.PHONY: render
render: docker-compose.yaml

docker-compose.yaml: docker-compose.yaml.jinja2 registries.yaml 
	jinja2 $^ >$@

.PHONY: clean
clean:
	docker-compose down
