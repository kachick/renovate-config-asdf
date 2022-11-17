# renovate-config-asdf

[![Build Status - Official Validator](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-official.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-official.yml?query=branch%3Amain)
[![Build Status - Regex](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-typescript.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-typescript.yml?query=branch%3Amain)
[![Build Status - Build Tools](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-crystal.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-crystal.yml?query=branch%3Amain)

## Usage

[Renovate sharable config](https://docs.renovatebot.com/config-presets/) for [.tool-versions (asdf)](https://github.com/asdf-vm/asdf-plugins/tree/master/plugins).

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base",
    "github>kachick/renovate-config-asdf#1.11.1"
  ]
}
```

This example referenced stable version as `kachick/renovate-config-asdf#TaggedVersion`.\
Because of default branch is frequently changed for developping.

Released versions can be checked in [github-tags](https://github.com/kachick/renovate-config-asdf/tags).

## Official asdf manager

This project started before [providing official asdf manager](https://github.com/renovatebot/renovate/pull/17166).
Currently nodejs definition is conflicting, so multiple PRs might be created when you enabled asdf manager as `config:base`.

Having some ways to avoid that.

1. Disable official asdf manager

```json
{
  "asdf": {
    "enabled": false
  }
}
```

2. Enable only regex managers for this project

```json
{
  "enabledManagers": ["regex"]
}
```

3. Send PRs to official as [this](https://github.com/renovatebot/renovate/pull/18612).
   \
   When importing most definitions to official is finished, this repository might be maintainance mode for current dependents.\
   Or adding new plugins and partially used as `"github>kachick/renovate-config-asdf//plugins/experimental_plugin_A`.

## Multiple versions and comments

Works since 1.10.0+.\
Only first versions for each tool. It is same restriction as [official manager](https://github.com/renovatebot/renovate/blob/4006ef4667cc416d40f88b0be6ba24690def8500/lib/modules/manager/asdf/readme.md?plain=1#L10).

Working examples: [1](https://github.com/kachick/sandbox-renovate-config-asdf/pull/1), [2](https://github.com/kachick/sandbox-renovate-config-asdf/pull/2), [3](https://github.com/kachick/sandbox-renovate-config-asdf/pull/4)

## Self updater

Seprated from `default.json` for now.\
You can use it as `github>kachick/renovate-config-asdf:self`.

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base",
    "github>kachick/renovate-config-asdf#1.11.1",
    "github>kachick/renovate-config-asdf:self"
  ]
}
```

[Working example](https://github.com/kachick/wait-other-jobs/pull/238)

## GitLab / Self-Hosted Runner

1.4.1+ tagged releases works in GitLab hosted repositories.\
See [#191](https://github.com/kachick/renovate-config-asdf/issues/191) and [#206](https://github.com/kachick/renovate-config-asdf/issues/206) for further detail.

[Working example](https://gitlab.com/kachick/sample-renovate-config-asdf/-/merge_requests/1)

NOTE

- Should pass `GITHUB_COM_TOKEN` for ENV with your **classic PAT**.
  \
  At 2022-10-22, [beta version of fine-grained PAT](https://github.blog/2022-10-18-introducing-fine-grained-personal-access-tokens-for-github/) does not support GraphQL API yet.\
  However [github-tags module of renovatebot is using GraphQL](https://github.com/renovatebot/renovate/blob/cc50beb0934874095fd2164b33dcb5fed7dbf421/lib/modules/datasource/github-tags/index.ts#L2).

## Limitations

- Want to cover asdf, however currently targeted only for some implementations.
- [asdf-java](https://github.com/halcyon/asdf-java) - Looks needed to read [this tsv](https://github.com/halcyon/asdf-java/tree/master/data) or [special datasource](https://github.com/renovatebot/renovate/tree/49465d460245552d6a409dcd7a95121a40358a28/lib/modules/datasource/adoptium-java)

## Working Examples

### Languages

- [bun](https://github.com/kachick/renovate-config-asdf/pull/27)
- [clojure](https://github.com/kachick/renovate-config-asdf/pull/39)
- [crystal](https://github.com/kachick/renovate-config-asdf/pull/7)
- [deno](https://github.com/kachick/renovate-config-asdf/pull/5)
- [elixir](https://github.com/kachick/renovate-config-asdf/pull/9)
- [elm](https://github.com/kachick/renovate-config-asdf/pull/10)
- [erlang](https://github.com/kachick/renovate-config-asdf/pull/18)
- [gauche](https://github.com/kachick/renovate-config-asdf/pull/42) - `gosh -V` instead of `gauche --version` See: [docs](https://practical-scheme.net/gauche/man/gauche-refe/Invoking-Gosh.html#Invoking-Gosh)
- [golang](https://github.com/kachick/renovate-config-asdf/pull/12)
- [haskell](https://github.com/kachick/renovate-config-asdf/pull/19)
- [idris](https://github.com/kachick/renovate-config-asdf/pull/20)
- [julia](https://github.com/kachick/renovate-config-asdf/pull/117)
- [kotlin](https://github.com/kachick/renovate-config-asdf/pull/25)
- [lua](https://github.com/kachick/renovate-config-asdf/pull/112)
- [nim](https://github.com/kachick/renovate-config-asdf/pull/6)
- [nodejs](https://github.com/kachick/renovate-config-asdf/pull/21)
- [ocaml](https://github.com/kachick/renovate-config-asdf/pull/15)
- [perl](https://github.com/kachick/renovate-config-asdf/pull/120)
- [php](https://github.com/kachick/renovate-config-asdf/pull/1)
- [python](https://github.com/kachick/renovate-config-asdf/pull/22) - Currently works only for [cpython](https://github.com/python/cpython)
- [ruby](https://github.com/kachick/renovate-config-asdf/pull/16) - Currently works only for [CRuby](https://github.com/ruby/ruby)
- [rust](https://github.com/kachick/renovate-config-asdf/pull/17)
- [scala](https://github.com/kachick/renovate-config-asdf/pull/24)
- [zig](https://github.com/kachick/renovate-config-asdf/pull/81)

### Tools

- [awscli(aws-cli)](https://github.com/kachick/renovate-config-asdf/pull/195)
- [cargo-make](https://github.com/kachick/renovate-config-asdf/pull/234)
- [direnv](https://github.com/kachick/renovate-config-asdf/pull/167)
- [dprint](https://github.com/kachick/renovate-config-asdf/pull/8)
- [helm](https://github.com/kachick/renovate-config-asdf/pull/94)
- [helmfile](https://github.com/kachick/renovate-config-asdf/pull/205)
- [hugo](https://github.com/kachick/sandbox-renovate-config-asdf/pull/7)
- [just](https://github.com/kachick/renovate-config-asdf/pull/261)
- [kustomize](https://github.com/kachick/renovate-config-asdf/pull/92)
- [shellcheck](https://github.com/kachick/renovate-config-asdf/pull/29)
- [shfmt](https://github.com/kachick/renovate-config-asdf/pull/30)
- [terraform](https://github.com/kachick/renovate-config-asdf/pull/137)
- [trivy](https://github.com/kachick/renovate-config-asdf/pull/96)

## Note

- [Official issue](https://github.com/renovatebot/renovate/issues/4051)
- [How to add/fix plugins?](CONTRIBUTING.md)
