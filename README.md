# renovate-config-dprint

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
    "github>kachick/renovate-config-dprint:plugins",
    "github>kachick/renovate-config-dprint:asdf"
  ]
}
```

[behavior example](https://github.com/kachick/renovate-config-dprint/pull/1)
