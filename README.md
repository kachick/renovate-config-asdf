# renovate-config-dprint

Base [Renovate config]((https://docs.renovatebot.com/config-presets/)) for [dprint](https://github.com/dprint/dprint) and the plugins.

```json
{
  "extends": [
    "github>kachick/renovate-config-dprint"
  ]
}
```

It currently targets [asdf-dprint](https://github.com/asdf-community/asdf-dprint) and [dprint official plugins](https://github.com/dprint?q=plugin&type=all&language=&sort=).

If you want to partially enable, pick from below.

```json
{
  "extends": [
    "github>kachick/renovate-config-dprint:plugins",
    "github>kachick/renovate-config-dprint:asdf"
  ]
}
```

[working example for a plugin](https://github.com/kachick/action-typescript-template/pull/7)
