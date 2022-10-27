VERSION :=
PLUGIN :=

check: lint-all test validate

.PHONY: test
test:
	npx tsc
	npx ts-node-test test/*.ts
	crystal spec

.PHONY: install-deps
install-deps:
	asdf install
	npm install
	shards install
	$(MAKE) build-tools

.PHONY: build-tools
build-tools:
	shards build

.PHONY: validate
validate:
	./bin/cli validate

.PHONY: release
release:
	./bin/cli release --version=${VERSION}

.PHONY: scaffold
scaffold:
	./bin/cli scaffold --plugin=${PLUGIN}
	$(MAKE) dprint-fix

.PHONY: lint-definitions
lint-definitions:
	./bin/cli lint

lint-all: crystal-lint-check dprint-check lint-definitions

crystal-lint-check: crystal-format-check
	./bin/ameba

.PHONY: crystal-format-check
crystal-format-check:
	crystal tool format --check

.PHONY: dprint-check
dprint-check:
	dprint check

lint-fix-all: crystal-lint-fix dprint-fix

.PHONY: crystal-lint-fix
crystal-lint-fix:
	crystal tool format
	./bin/ameba --fix

.PHONY: dprint-fix
dprint-fix:
	dprint fmt
