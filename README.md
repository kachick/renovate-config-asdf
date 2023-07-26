# renovate-config-asdf

[![Build Status - Official Validator](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-official.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-official.yml?query=branch%3Amain)
[![Build Status - Regex](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-typescript.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-typescript.yml?query=branch%3Amain)
[![Build Status - Build Tools](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-crystal.yml/badge.svg?branch=main)](https://github.com/kachick/renovate-config-asdf/actions/workflows/ci-crystal.yml?query=branch%3Amain)

## Overview

[Renovate sharable config](https://docs.renovatebot.com/config-presets/) for [.tool-versions (asdf)](https://github.com/asdf-vm/asdf-plugins/tree/master/plugins).

Since renovate version [34.25.0](https://github.com/renovatebot/renovate/pull/18612#issuecomment-1315123140), official asdf manager imported most plugins of this repository.\
And it merged [extended hugo releases](https://github.com/gohugoio/hugo/blob/af23cdca9c9c230ffbffbab96f9600a78c76b75f/docs/content/en/troubleshooting/faq.md?plain=1#L50-L60) in following [34.28.0](https://github.com/renovatebot/renovate/pull/18987#issuecomment-1320388809).
So you don't need to depend this config now!

(Below sections are historical. You can leave here.)

## Usage

In someday, I might add some definitions for my personal use again. Then they should be used as below.

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "github>kachick/renovate-config-asdf//plugins/hugo.json5#1.11.1",
    "github>kachick/renovate-config-asdf:self"
  ],
  "enabledManagers": ["asdf", "regex"]
}
```

This example referenced tagged version and enabled self updater.

## Multiple versions and comments

Works since 1.10.0+.\
Only first versions for each tool. It is same restriction as [official manager](https://github.com/renovatebot/renovate/blob/4006ef4667cc416d40f88b0be6ba24690def8500/lib/modules/manager/asdf/readme.md?plain=1#L10).

Working examples: [1](https://github.com/kachick/sandbox-renovate-config-asdf/pull/1), [2](https://github.com/kachick/sandbox-renovate-config-asdf/pull/2), [3](https://github.com/kachick/sandbox-renovate-config-asdf/pull/4)

## GitLab / Self-Hosted Runner

1.4.1+ tagged releases works in GitLab hosted repositories.\
See [#191](https://github.com/kachick/renovate-config-asdf/issues/191) and [#206](https://github.com/kachick/renovate-config-asdf/issues/206) for further detail.

[Working example](https://gitlab.com/kachick/sample-renovate-config-asdf/-/merge_requests/1)

NOTE

- Should pass `GITHUB_COM_TOKEN` for ENV with your **classic PAT**.
  \
  At 2022-10-22, [beta version of fine-grained PAT](https://github.blog/2022-10-18-introducing-fine-grained-personal-access-tokens-for-github/) does not support GraphQL API yet.\
  However [github-tags module of renovatebot is using GraphQL](https://github.com/renovatebot/renovate/blob/cc50beb0934874095fd2164b33dcb5fed7dbf421/lib/modules/datasource/github-tags/index.ts#L2).

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
- [typos](https://github.com/kachick/renovate-config-asdf/pull/1035)
- [yamlfmt](https://github.com/kachick/renovate-config-asdf/pull/931)

## Note

- [First official issue](https://github.com/renovatebot/renovate/issues/4051)
- [Imported PR](https://github.com/renovatebot/renovate/pull/18612)
- [How to add/fix plugins?](CONTRIBUTING.md)
