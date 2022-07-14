# renovate-config-asdf

## Usage

🚧 [Renovate sharable config](https://docs.renovatebot.com/config-presets/) for [.tool-versions (asdf)](https://github.com/asdf-vm/asdf-plugins/tree/master/plugins). 🚧

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base",
    "github>kachick/renovate-config-asdf"
  ]
}
```

If you want to narrow Renovate effect for example you are basically using dependabot, removing `config:base` and specifying `enabledManagers` might fit.

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

- [asdf-python](https://github.com/danhper/asdf-python) - Currently targeted only for [cpython](https://github.com/python/cpython)
- [asdf-java](https://github.com/halcyon/asdf-java) - Looks needed to read [tsv](https://github.com/halcyon/asdf-java/tree/master/data)

## Example

- [Bump nodejs](https://github.com/kachick/renovate-config-asdf/pull/21)
- [Bump haskell](https://github.com/kachick/renovate-config-asdf/pull/19)
- [Bump idris](https://github.com/kachick/renovate-config-asdf/pull/20)
- [Bump erlang](https://github.com/kachick/renovate-config-asdf/pull/18)
- [Bump rust](https://github.com/kachick/renovate-config-asdf/pull/17)
- [Bump ocaml](https://github.com/kachick/renovate-config-asdf/pull/15)
- [Bump golang](https://github.com/kachick/renovate-config-asdf/pull/12)
- [Bump elm](https://github.com/kachick/renovate-config-asdf/pull/10)
- [Bump deno](https://github.com/kachick/renovate-config-asdf/pull/5)
- [Bump crystal](https://github.com/kachick/renovate-config-asdf/pull/7)
- [Bump elixir](https://github.com/kachick/renovate-config-asdf/pull/9)
- [Bump ruby](https://github.com/kachick/renovate-config-asdf/pull/16)
- [Bump kotlin](https://github.com/kachick/renovate-config-asdf/pull/4242)
- [Bump scala](https://github.com/kachick/renovate-config-asdf/pull/4242)
- [Bump nim](https://github.com/kachick/renovate-config-asdf/pull/6)
- [Bump python](https://github.com/kachick/renovate-config-asdf/pull/22)
- [Bump php](https://github.com/kachick/renovate-config-asdf/pull/1)
- [Bump dprint](https://github.com/kachick/renovate-config-asdf/pull/8)

## Note

- [Official issue](https://github.com/renovatebot/renovate/issues/4051)
