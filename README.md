# renovate-config-dprint

## Usage

[Renovate sharable config](https://docs.renovatebot.com/config-presets/) for [dprint](https://github.com/dprint/dprint) and the plugins.

```json
{
  "extends": [
    "config:base",
    "github>kachick/renovate-config-dprint"
  ]
}
```

It currently targets [asdf-dprint](https://github.com/asdf-community/asdf-dprint) and [dprint official plugins](https://github.com/dprint?q=plugin&type=all&language=&sort=).

If you want to partially enable, pick from below.

```json
{
  "extends": [
    "config:base",
    "github>kachick/renovate-config-dprint:plugins",
    "github>kachick/renovate-config-dprint:asdf"
  ]
}
```

When updating by bot as dependabot and/or renovate, I recommend to check the dprint diff in CI.\
A way is to integrate [dprint/check](https://github.com/dprint/check) in your GitHub Actions.

## Example

- [Bump plugin](https://github.com/kachick/renovate-config-dprint/pull/1)
- [Bump .tool-versions](https://github.com/kachick/renovate-config-dprint/pull/6)

## Note

- [Official issues tracker](https://github.com/kachick/renovate-config-dprint/issues/7)
