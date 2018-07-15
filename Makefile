.DEFAULT_GOAL := help

build-worker:  ## Builds the worker docker image.
	docker build --no-cache -t fritogotlayed/buildbot-worker -f ./simple/worker.dockerfile .

build-worker-with-cache:  ## Builds the worker docker image.
	docker build -t fritogotlayed/buildbot-worker -f ./simple/worker.dockerfile .

help:  ## Prints this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
