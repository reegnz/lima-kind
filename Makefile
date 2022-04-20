.PHONY: all
all: lima kind docker-cache

.PHONY: lima
lima:
	$(MAKE) -C lima up

.PHONY: kind
kind: lima
	$(MAKE) -C kind up

.PHONY: docker-cache
docker-cache: lima kind
	$(MAKE) -C docker-cache up

.PHONY:
clean:
	$(MAKE) -C lima clean
