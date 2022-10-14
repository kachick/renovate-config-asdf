#! /usr/bin/env crystal

module RenovateConfigAsdf
  module ReleaseManager
    def self.release(version : String) : Void
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      working_branch = "tmp-release-#{version}"

      puts "Bumping to `#{version}` ..."

      `git switch -c "#{working_branch}"`

      origin = File.read("default.json")
      replaced = releasing_json(origin, version)
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

    def self.releasing_json(origin : String, version : String) : String
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      origin.gsub(%r["(?:local|github)(?<before>>kachick/renovate-config-asdf//plugins/\S+?\.json5?)(?<after>",?)], "\"github\\k<before>##{version}\\k<after>")
    end
  end
end
