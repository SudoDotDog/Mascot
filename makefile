# Paths
build := typescript/tsconfig.build.json
dev := typescript/tsconfig.dev.json

# NPX functions
tsc := node_modules/.bin/tsc
ts_node := node_modules/.bin/ts-node
mocha := node_modules/.bin/mocha

# Docker
local_image_name := mascot-local
local_image_file := docker/local.dockerfile

.IGNORE: clean-linux stop-local

main: build-local sh-local

build-local:
	@echo "[INFO] Building for local"
	@docker build -t $(local_image_name) -f $(local_image_file) .

sh-local: stop-local
	@echo "[INFO] Running for local"
	@docker run -it -p 8080:8080 --name $(local_image_name) $(local_image_name) sh

stop-local:
	@echo "[INFO] Stopping running local container"
	@docker rm $(local_image_name)

build:
	@echo "[INFO] Building for production"
	@NODE_ENV=production $(tsc) --p $(build)

tests:
	@echo "[INFO] Testing with Mocha"
	@NODE_ENV=test $(mocha)

cov:
	@echo "[INFO] Testing with Nyc and Mocha"
	@NODE_ENV=test \
	nyc $(mocha)

install:
	@echo "[INFO] Installing dev Dependencies"
	@yarn install --production=false

install-prod:
	@echo "[INFO] Installing Dependencies"
	@yarn install --production=true

clean: clean-linux
	@echo "[INFO] Cleaning release files"

clean-linux:
	@echo "[INFO] Cleaning dist files"
	@rm -rf .nyc_output
	@rm -rf coverage
