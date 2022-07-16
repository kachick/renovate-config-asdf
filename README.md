# renovate-config-asdf

## Usage

[Renovate sharable config](https://docs.renovatebot.com/config-presets/) for [.tool-versions (asdf)](https://github.com/asdf-vm/asdf-plugins/tree/master/plugins).

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base",
    "github>kachick/renovate-config-asdf"
  ]
}
```

If you want to narrow Renovate effect, for example you are basically using dependabot, removing `config:base` and specifying `enabledManagers` might fit.

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

Want to cover asdf, however currently targeted only for github hosted and/or some compilers/interpreters.

- [asdf-zig](https://github.com/asdf-community/asdf-zig) - I don't know why [it](plugins/zig.json5) does not work...
- [asdf-python](https://github.com/danhper/asdf-python) - Currently targeted only for [cpython](https://github.com/python/cpython)
- [asdf-java](https://github.com/halcyon/asdf-java) - Looks needed to read [tsv](https://github.com/halcyon/asdf-java/tree/master/data)

## Working Examples

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
- [elixir](https://github.com/kachick/renovate-config-asdf/pull/9)
- [ruby](https://github.com/kachick/renovate-config-asdf/pull/16)
- [kotlin](https://github.com/kachick/renovate-config-asdf/pull/25)
- [scala](https://github.com/kachick/renovate-config-asdf/pull/24)
- [clojure](https://github.com/kachick/renovate-config-asdf/pull/26)
- [nim](https://github.com/kachick/renovate-config-asdf/pull/6)
- [python](https://github.com/kachick/renovate-config-asdf/pull/22)
- [php](https://github.com/kachick/renovate-config-asdf/pull/1)
- [dprint](https://pgithub.com/kachick/renovate-config-asdf/pull/8)
- [shellcheck](https://github.com/kachick/renovate-config-asdf/pull/29)
- [shfmt](https://github.com/kachick/renovate-config-asdf/pull/30)

## Note

- [Official issue](https://github.com/renovatebot/renovate/issues/4051)
