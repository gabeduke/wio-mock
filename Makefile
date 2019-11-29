REGISTRY := dukeman
IMAGE := wio-mock
TAG := 0.1.0

.DEFAULT_GOAL := help

##@ Application

run: ## Run in development mode
	go run main.go

build: ## Build binary
	mkdir -p build
	go build -o build/wio

docker-build: ## Build docker image
	docker build -t $(REGISTRY)/$(IMAGE):$(TAG) .

docker-push: ## Push docker image to remote registry
	docker push $(REGISTRY)/$(IMAGE):$(TAG)

##@ Helpers

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

