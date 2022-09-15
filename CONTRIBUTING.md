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
❯ ./bin/cli -h
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

## How to check regex(RE2) ~ e.g. In Ruby ~

https://github.com/google/re2/wiki/Syntax is the reference.
Actual behavior checking in irb is below.

Install https://github.com/mudge/re2/

```console
$ brew install re2
$ gem install re2 -- --with-re2-dir=$(brew --prefix re2)
Building native extensions with: '--with-re2-dir=/home/linuxbrew/.linuxbrew/opt/re2'
This could take a while...
Successfully installed re2-1.4.0
Parsing documentation for re2-1.4.0
Installing ri documentation for re2-1.4.0
Done installing documentation for re2 after 0 seconds
1 gem installed
$ irb -rre2
irb(main):001:0>
```

It looks replacing `(?<major>` with `(?P<major>`.

```ruby
irb(main):026:0> RE2::Regexp.new('^(?P<major>\\d+?)[_.](?P<minor>\d+?)[_.](?P<patch>\d+)$').match('0_9-12')
=> nil
irb(main):027:0> RE2::Regexp.new('^(?P<major>\\d+?)[_.](?P<minor>\d+?)[_.](?P<patch>\d+)$').match('0.9.12')
=> #<RE2::MatchData "0.9.12" 1:"0" 2:"9" 3:"12">
irb(main):028:0> m = _
=> #<RE2::MatchData "0.9.12" 1:"0" 2:"9" 3:"12">
irb(main):029:0> m[:major]
=> "0"
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
