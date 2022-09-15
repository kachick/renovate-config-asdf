#! /usr/bin/env crystal

module RenovateConfigAsdf
  module ReleaseManager
    def self.release(version : String) : Void
      raise ArgumentError.new("given #{version} does not satisfy our versioning format") unless version?(version)

      working_branch = "tmp-release-#{version}"

      puts "Bumping to `#{version}` ..."

      `git switch -c "#{working_branch}"`

      File.open("default.json", "r+") do |file|
        current = file.gets_to_end
        replaced = current.gsub(%r[(?<before>"local>kachick/renovate-config-asdf//plugins/\S+?\.json5?)(?<after>",?)], "\\k<before>##{version}\\k<after>")
        file.rewind
        file.write_string(replaced.to_slice)
      end

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

if ARGV.size >= 2 && ARGV.first == "run"
  RenovateConfigAsdf::ReleaseManager.release(ARGV[1])
end
