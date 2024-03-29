# Contributing

We recommend to send PRs into [official asdf manager](https://github.com/renovatebot/renovate/tree/84bb830e00134bd32ff2cb5b94411fd6a080b4c4/lib/modules/manager/asdf).

However when you would add new plugins into this repository from some reasons, this guide might help.

## Setup environments

Author is using [Nix](https://nixos.org/) to maintain this repository.
Because of installing crystal via asdf-crystal often make missing lib* packages with depending the PKG_CONFIG.

```console
$ nix develop
(First execution might take long time. Then execute prepared bash with nodejs, crystal and other tools.)
$ make setup
npm install
shards install
shards build
...
```

## Tools

```console
$ ./bin/cli -h
Usage: [arguments]
    -h, --help                       Show this help
    validate                         Validate definitions with renovate provided tool
    lint                             Lint definitions
    scaffold                         Generate files for first step of adding new plugins
    release                          Add git tags in default.json
    touch                            Update renovate.json labels to toriger renovate
    merge                            Update default.json from plugins/* definitions
    generate_matrix                  Generate matrix JSON from STDIN for GitHub Actions
```

## Tests

```console
$ make check
dprint check
./bin/cli lint
npx tsc
npm test
crystal spec
./bin/cli validate
```

## File type

- Use [*.json5](https://github.com/renovatebot/renovate/issues/16001#issuecomment-1152568230) for all plugins to keep consistency. (Might be changed in future. VSCode does not run JSON schema for json5.)
- Do **NOT** use [JSON5](https://json5.org/) extended features except comments, just using JSON5 as an alternative JSONC in this repo.

## Define plugins

- `github-releases` will work in most cases. We have the scaffold. Run and update diff.
  - `make scaffold PLUGIN=awesome-plugin-name`
  - Add [RE2 tests with actual data](test/examples.ts) if it has `extractVersionTemplate`
- Some cases need struggling because of they have tricky versioning in github tags/releases. Examples are below.
  - [Using renovate provided definitions](plugins/ruby.json5)
  - [Using docker image for the datasource](plugins/gauche.json5)
  - [Using multiple datasources because they have another repository in different versions](plugins/scala.json5)
- [When it is using no semantic versioning or customized one](plugins/clojure.json5)

## Check actual Renovate behaviors

1. Intentionally specify old version into [example definition](examples/.tool-versions).
2. Modify [root config](renovate.json) with executing `make touch` to trigger Renovate.
3. Check logs at [dashboard](https://app.renovatebot.com/dashboard#github/kachick/renovate-config-asdf).
   - Need private permissions.
   - [Check in forked repo before sending to upstream](#93) helps me a lot.
4. [Check PR has been sent as correct](https://github.com/kachick/renovate-config-asdf/pulls?q=is%3Apr+label%3Arenovate+).

## Basic Regex ensuring

Looks not in RE2, however https://regex101.com is useful. See https://regex101.com/r/L2micV as an actual example for gauche

## Check actual RE2 behavior with Node.js

<https://github.com/google/re2/wiki/Syntax> is the reference.

Actual behavior checking requires <https://github.com/uhop/node-re2> that include <https://github.com/google/re2/>.

```console
$ npm install
$ npx tsx
Welcome to Node.js v20.4.0.
Type ".help" for more information.
```

```typescript
> const RE2 = require("re2");
undefined
> let pattern = new RE2("^v(?<version>\\S+)");
undefined
> pattern.exec("v1.25.2");
[
  'v1.25.2',
  '1.25.2',
  index: 0,
  input: 'v1.25.2',
  groups: [Object: null prototype] { version: '1.25.2' }
]
> pattern.exec("v1.25.2").groups["version"];
'1.25.2'
```

## Release new version with github-tags - # For maintainer

```console
$ make release VERSION=0.4.2
Bumping to `0.4.2` ...
Done! you should manually push to GitHub with ...
$ git push origin 0.4.2
Completed!
```

## Note

- [Allowed syntax of default.json](https://docs.renovatebot.com/config-presets/)
- [regexManagers](https://docs.renovatebot.com/modules/manager/regex/)
- [datasource definitions](https://github.com/renovatebot/renovate/tree/2e957baed962d65cb8e40136edc142af6014ad95/lib/modules/datasource)
- [versioning definitions](https://github.com/renovatebot/renovate/tree/2e957baed962d65cb8e40136edc142af6014ad95/lib/modules/versioning)
