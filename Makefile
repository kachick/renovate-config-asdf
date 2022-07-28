VERSION :=

check: lint-all test validate

.PHONY: test
test:
	crystal spec

.PHONY: install-deps
install-deps:
	asdf install
	npm install

.PHONY: validate
validate:
	crystal run scripts/validator.cr -- run

.PHONY: release
release:
	crystal run scripts/release_manager.cr -- run ${VERSION}

lint-all: crystal-format-check dprint-check

.PHONY: crystal-format-check
crystal-format-check:
	crystal tool format --check

.PHONY: dprint-check
dprint-check:
	dprint check

lint-fix-all: crystal-format-fix dprint-fix

.PHONY: crystal-format-fix
crystal-format-fix:
	crystal tool format

.PHONY: dprint-fix
dprint-fix:
	dprint fmt
