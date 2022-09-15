## Setup environments

```console
$ make install-deps
asdf install
crystal 1.5.0 is already installed
dprint 0.30.3 is already installed
nodejs 18.7.0 is already installed
npm install

up to date, audited 691 packages in 1s

145 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities

shards install
Resolving dependencies
Fetching https://github.com/crystal-ameba/ameba.git
Installing ameba (1.1.0)
Postinstall of ameba: make bin && make run_file
Writing shard.lock

crystal build src/cli.cr -o bin/cli
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
```

## Test tools

```console
$ make check
crystal tool format --check
dprint check
crystal spec
```

## File type

- Use [*.json5](https://github.com/renovatebot/renovate/issues/16001#issuecomment-1152568230) for all plugins to keep consistency. (Might be changed in future. VSCode does not run JSON schema for json5.)
- Do **NOT** use [JSON5](https://json5.org/) extended features except comments, just using JSON5 as an alternative JSONC in this repo.

## Define plugins

- `github-tags` will work in most cases. We have the scaffold. Run and update diff.
  - `make scaffold PLUGIN=awesome-plugin-name`
  - Add RE2 tests with actual data into `test/regex_test.mjs` if it has a typical definitions
- Some cases need struggling because of they have tricky versioning in github tags/releases. Examples are below.
  - [Using renovate provided definitions](plugins/ruby.json5)
  - [Using docker image for the datasource](plugins/gauche.json5)
  - [Using multiple datasources because they have another repository in different versions](plugins/scala.json5)
- [When it is using no semantic versioning or customized one](plugins/clojure.json5)

## Check actual behaviors with this repo

1. Intentionally specify old version into [example definition](examples/.tool-versions).
2. Modify [root config](renovate.json) to trigger Renovate. So toggle `"ignore-this-label-just-for-trigger-renovate-1"` suffix.
3. Check logs at [dashboard](https://app.renovatebot.com/dashboard#github/kachick/renovate-config-asdf). (Having private visibility?)
4. Check PR has been sent as correct in [PRs](https://github.com/kachick/renovate-config-asdf/pulls).

## Basic Regex ensuring

Looks not in RE2, however https://regex101.com is useful. See https://regex101.com/r/L2micV as an actual example for gauche

## Check actual RE2 behavior with Node.js

https://github.com/google/re2/wiki/Syntax is the reference.
Actual behavior checking in irb is below.

Need https://github.com/mudge/re2/ and the bindings.

```console
$ brew install re2
$ npm install
$ node
Welcome to Node.js v18.9.0.
Type ".help" for more information.
```

```js
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

## Release new version with github-tags

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
