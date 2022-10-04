#! /usr/bin/env crystal

module RenovateConfigAsdf
  module ReleaseManager
    def self.release(version : String) : Void
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      working_branch = "tmp-release-#{version}"

      puts "Bumping to `#{version}` ..."

      `git switch -c "#{working_branch}"`

      origin = File.read("default.json")
      replaced = origin.gsub(%r[(?<before>"local>kachick/renovate-config-asdf//plugins/\S+?\.json5?)(?<after>",?)], "\\k<before>##{version}\\k<after>")
      File.write("default.json", replaced)

      `git add default.json`
      `git commit -m "Release version #{version}"`
      `git tag "#{version}"`
      `git switch -`
      `git branch -D "#{working_branch}"`

      puts "Done! you should manually push to GitHub as `git diff 'main...#{version}'` and `git push origin '#{version}'`"
    end

    def self.version?(version : String) : Bool
      /\A\d+?\.\d+?\.\d+\z/.matches?(version)
    end
  end
end
