VERSION :=
PLUGIN :=

check: lint-all test validate

.PHONY: test
test:
	npx tsc
	npm test
	crystal spec

.PHONY: setup
setup:
	npm install
	shards install
	$(MAKE) build-tools

.PHONY: build-tools
build-tools:
	shards build --production

.PHONY: validate
validate:
	./bin/cli validate

.PHONY: merge
merge:
	./bin/cli merge

.PHONY: release
release:
	./bin/cli release --version=${VERSION}

.PHONY: scaffold
scaffold:
	./bin/cli scaffold --plugin=${PLUGIN}
	$(MAKE) dprint-fix
	@echo '--------------------------------------------------'
	@echo '1. Update generated files'
	@echo '2. Add tests into test/examples.ts if extractVersionTemplate exists'
	@echo '3. Merge configs with `make merge`'

.PHONY: lint-definitions
lint-definitions:
	./bin/cli lint

lint-all: crystal-lint-check dprint-check lint-definitions deno_lint typos-check

crystal-lint-check: crystal-format-check
	ameba --except Metrics

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
	ameba --except Metrics --fix

.PHONY: deno_lint
deno_lint:
	deno lint

.PHONY: typos-check
typos-check:
	typos . .github .vscode

.PHONY: dprint-fix
dprint-fix:
	dprint fmt

.PHONY: touch
touch:
	./bin/cli touch

.PHONY: versions
deps:
	nix --version
	node --version
	crystal --version
	# It returns error even if correctly show the version
	# nixpkgs-fmt --version
	dprint --version
	deno --version
	typos --version
	shards --version
