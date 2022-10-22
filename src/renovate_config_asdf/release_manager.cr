#! /usr/bin/env crystal

module RenovateConfigAsdf
  module ReleaseManager
    def self.release(version : String) : Void
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      working_branch = "tmp-release-#{version}"

      puts "Bumping to `#{version}` ..."

      update_readme("README.md", version)

      `git add README.md`
      `git commit -m "Update examples to releasing #{version}"`
      `git switch -c "#{working_branch}"`

      replace_json(DEAFULT_JSON_PATH, version)

      `git add default.json`
      `git commit -m "Release version #{version}"`
      `git tag "#{version}"`
      `git switch -`
      `git branch -D "#{working_branch}"`

      puts "Done! you should manually push to GitHub with below commands", "git push origin main #{version}"
    end

    def self.version?(version : String) : Bool
      /\A\d+?\.\d+?\.\d+\z/.matches?(version)
    end

    def self.releasing_json(origin : String, version : String) : String
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      origin.gsub(%r["(?:local|github)(?<before>>kachick/renovate-config-asdf//plugins/\S+?\.json5?)(?<after>",?)], "\"github\\k<before>##{version}\\k<after>")
    end

    def self.replace_json(path : String, version : String) : Void
      File.write(path, releasing_json(File.read(path), version))
    end

    def self.replaced_readme(origin : String, version : String) : String
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      origin.gsub(%r[kachick/renovate-config-asdf#\d+?\.\d+?\.\d+], "kachick/renovate-config-asdf##{version}")
    end

    def self.update_readme(path : String, version : String) : Void
      File.write(path, replaced_readme(File.read(path), version))
    end
  end
end
