REGISTRY := dukeman
IMAGE := wio-mock
TAG := 0.1.0
PORT = 8081

.DEFAULT_GOAL := help

##@ Go
.PHONY: build run

run: ## Run in development mode
	go run main.go

build: ## Build binary
	mkdir -p build
	go build -o build/wio

##@ Docker
.PHONY: docker-build docker-run docker-push

docker-build: ## Build docker image
	docker build -t $(REGISTRY)/$(IMAGE):$(TAG) .

docker-run: ## Run docker image
	docker run -p $(PORT):$(PORT) -e PORT=$(PORT) -it $(REGISTRY)/$(IMAGE):$(TAG)

docker-push: ## Push docker image to remote registry
	docker push $(REGISTRY)/$(IMAGE):$(TAG)

##@ Kubernetes

deploy: ## Deploy to kubernetes
	kubectl kustomize deploy | kubectl apply -f -

##@ Helpers
.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

