VERSION :=

check: lint-all test validate

.PHONY: test
test:
	crystal spec

.PHONY: install-deps
install-deps:
	asdf install
	npm install
	shards install

.PHONY: validate
validate:
	crystal run scripts/validator.cr -- run

.PHONY: release
release:
	crystal run scripts/release_manager.cr -- run ${VERSION}

.PHONY: lint-examples
lint-examples:
	crystal run scripts/linter.cr -- run

lint-all: crystal-lint-check dprint-check lint-examples

crystal-lint-check: crystal-format-check
	bin/ameba

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
	bin/ameba --fix

.PHONY: dprint-fix
dprint-fix:
	dprint fmt
