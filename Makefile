VERSION :=

check: lint-all test validate

.PHONY: test
test:
	crystal spec

.PHONY: install-deps
install-deps:
	asdf install
	npm install
	echo 'Install ameba manually (recommend brew)'

.PHONY: validate
validate:
	crystal run scripts/validator.cr -- run

.PHONY: release
release:
	crystal run scripts/release_manager.cr -- run ${VERSION}

lint-all: crystal-lint-check dprint-check

.PHONY: crystal-lint-check
crystal-lint-check:
	crystal tool format --check
	ameba

.PHONY: dprint-check
dprint-check:
	dprint check

lint-fix-all: crystal-lint-fix dprint-fix

.PHONY: crystal-lint-fix
crystal-lint-fix:
	crystal tool format
	ameba --fix

.PHONY: dprint-fix
dprint-fix:
	dprint fmt
