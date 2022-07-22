## File type

- [Use .json5 if needed to add comments.](https://github.com/renovatebot/renovate/issues/16001#issuecomment-1152568230)
- Do not use [JSON5](https://json5.org/) extended features except comments, just using JSON5 as an alternative [json-c](https://github.com/json-c/json-c).

## Release new version with github-tags

```console
$ ./scripts/release_new_version.rb 0.4.2
$ git push origin 0.4.2
Bumping to `0.4.2` ...
Done! you should manually push to GitHub with ``
```

## Note

- [How to write default.json](https://docs.renovatebot.com/config-presets/)
