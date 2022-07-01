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

If you basically using dependabot and you want to suppress duplicated renovate PRs, specifying `enabledManagers` might help.

```json
{
  "enabledManagers": ["regex"]
}
```

Below is my latest config. [I basically use dependabot for now.](https://github.com/kachick/wait-other-jobs/blob/01f5633635d67cf00f013b666429e5651ce92d3f/README.md?plain=1#L51-L83)

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "github>kachick/renovate-config-dprint"
  ],
  "labels": ["dependencies", "renovate"],
  "automerge": true,
  "enabledManagers": ["regex"]
}
```

## Example

- [Bump plugin](https://github.com/kachick/renovate-config-dprint/pull/1)
- [Bump .tool-versions](https://github.com/kachick/renovate-config-dprint/pull/6)

## Note

- [Official issues tracker](https://github.com/kachick/renovate-config-dprint/issues/7)
