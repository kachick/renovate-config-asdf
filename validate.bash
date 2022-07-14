set -eux

for file in $(git ls-files 'renovate.json' 'default.json' 'asdf-plugins/*.json'); do
  # FIXME!: Currently `renovate.json` checked in each iteration :<
 	RENOVATE_CONFIG_FILE=${file} npx renovate-config-validator
done
