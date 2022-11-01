.PHONY: build buildx run fg bg push login
default: build
run: fg

REPO	= docker.io/andypippin
IMAGE	= config-server
TAG	= latest

build: Dockerfile
	@docker build -t $(IMAGE):$(TAG) .

buildx: Dockerfile
	@docker buildx build -t $(REPO)/$(IMAGE):$(TAG) --platform linux/amd64,linux/arm64 --push .

fg: build
	@docker run -p 3000:3000 $(IMAGE):$(TAG)

bg: build
	@docker run -d -p 3000:3000 $(IMAGE):$(TAG)

push: login build
	@docker tag $(IMAGE):$(TAG) $(REPO)/$(IMAGE):$(TAG)
	@docker push $(REPO)/$(IMAGE):$(TAG)

login:
	@docker login $(REPO)
