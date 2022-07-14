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

## Example

- [Bump .tool-versions](https://github.com/kachick/renovate-config-asdf/pull/NNN)

## Note

- [Official issue](https://github.com/renovatebot/renovate/issues/4051)
