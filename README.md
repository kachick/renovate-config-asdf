# renovate-config-asdf

[![Build Status](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci.yml?query=branch%3Amain)

## Usage

[Renovate sharable config](https://docs.renovatebot.com/config-presets/) for [.tool-versions (asdf)](https://github.com/asdf-vm/asdf-plugins/tree/master/plugins).

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base",
    "github>kachick/renovate-config-asdf#1.2.0"
  ]
}
```

This example referenced stable version as `#1.2.0`. Versions can be checked in [github-tags](https://github.com/kachick/renovate-config-asdf/tags).
Because of default branch is frequently changed for developping.

If you want to narrow Renovate effect, for example you are basically using dependabot, removing `config:base` and specifying `enabledManagers` might fit.

Below is an actual example for me. It points default branch of this repository to use development version.

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "github>kachick/renovate-config-asdf"
  ],
  "labels": ["dependencies", "renovate"],
  "enabledManagers": ["regex"]
}
```

## Limitations

- Want to cover asdf, however currently targeted only for some implementations.
- [asdf-java](https://github.com/halcyon/asdf-java) - Looks needed to read [this tsv](https://github.com/halcyon/asdf-java/tree/master/data)

## Working Examples

### Languages

- [nodejs](https://github.com/kachick/renovate-config-asdf/pull/21)
- [haskell](https://github.com/kachick/renovate-config-asdf/pull/19)
- [idris](https://github.com/kachick/renovate-config-asdf/pull/20)
- [erlang](https://github.com/kachick/renovate-config-asdf/pull/18)
- [rust](https://github.com/kachick/renovate-config-asdf/pull/17)
- [ocaml](https://github.com/kachick/renovate-config-asdf/pull/15)
- [golang](https://github.com/kachick/renovate-config-asdf/pull/12)
- [elm](https://github.com/kachick/renovate-config-asdf/pull/10)
- [deno](https://github.com/kachick/renovate-config-asdf/pull/5)
- [bun](https://github.com/kachick/renovate-config-asdf/pull/27)
- [crystal](https://github.com/kachick/renovate-config-asdf/pull/7)
- [zig](https://github.com/kachick/renovate-config-asdf/pull/81)
- [elixir](https://github.com/kachick/renovate-config-asdf/pull/9)
- [ruby](https://github.com/kachick/renovate-config-asdf/pull/16) - Currently works only for [CRuby](https://github.com/ruby/ruby)
- [kotlin](https://github.com/kachick/renovate-config-asdf/pull/25)
- [scala](https://github.com/kachick/renovate-config-asdf/pull/24)
- [clojure](https://github.com/kachick/renovate-config-asdf/pull/39)
- [gauche](https://github.com/kachick/renovate-config-asdf/pull/42) - `gosh -V` instead of `gauche --version` See: [docs](https://practical-scheme.net/gauche/man/gauche-refe/Invoking-Gosh.html#Invoking-Gosh)
- [nim](https://github.com/kachick/renovate-config-asdf/pull/6)
- [python](https://github.com/kachick/renovate-config-asdf/pull/22) - Currently works only for [cpython](https://github.com/python/cpython)
- [php](https://github.com/kachick/renovate-config-asdf/pull/1)

### Tools

- [dprint](https://github.com/kachick/renovate-config-asdf/pull/8)
- [shellcheck](https://github.com/kachick/renovate-config-asdf/pull/29)
- [shfmt](https://github.com/kachick/renovate-config-asdf/pull/30)
- [kustomize](https://github.com/kachick/renovate-config-asdf/pull/92)
- [helm](https://github.com/kachick/renovate-config-asdf/pull/94)
- [trivy](https://github.com/kachick/renovate-config-asdf/pull/95)

## Note

- [Official issue](https://github.com/renovatebot/renovate/issues/4051)
- [How to add/fix plugins?](CONTRIBUTING.md)
