#!/usr/bin/env ruby
# coding: us-ascii
# frozen_string_literal: true
# shareable_constant_value: experimental_everything

require 'fileutils'

version = ARGV.first.freeze
raise ArgumentError, "given #{version} does not satisfy our versioning" unless /\A\d+?\.\d+?\.\d+\z/.match?(version)

puts "Bumping to `#{version}` ..."

`git switch -c "tmp-release-#{version}"`

File.open('default.json', 'r+') do |file|
  current = file.read
  replaced = current.gsub(%r!(?<before>"local>kachick/renovate-config-asdf//plugins/\S+?\.json5?)(?<after>",?)!) {
    "#{Regexp.last_match(:before)}##{version}#{Regexp.last_match(:after)}"
  }
  file.rewind
  file.write(replaced)
end

`git add default.json`
`git commit -m 'Specify git ref of referenced plugins/*'`
`git tag "#{version}"`
`git switch -`

puts "Done! you should manually push to GitHub as `git diff 'main...#{version}'` and `git push origin '#{version}'`"
