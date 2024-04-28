.PHONY: *
.DEFAULT_GOAL:=help

# Internal
ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION=$(shell cat $(ROOT_DIR)/VERSION)
CLJ=clojure -J-Dclojure.main.report=stderr

##@ Commands

run: ## Start application
	clojure -X clj-restaurants.main/main

compose-up: ## Start containers
	echo "Starting containers..."
	docker compose up --build -d --remove-orphans
	echo "Containers started."
	echo "Waiting 10 seconds to ensure all the containers are started..."
	sleep 10

compose-down: ## Stop containers
	docker-compose down --remove-orphans

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


