#! /usr/bin/env crystal

require "option_parser"

require "./*"

module RenovateConfigAsdf
  module Cli
    def self.run(args : Array(String))
      validate = false
      lint = false
      scaffold = false
      release = false
      plugin = ""
      version = ""

      parser = OptionParser.new do |psr|
        psr.banner = "Usage: [arguments]"
        psr.on("-h", "--help", "Show this help") do
          puts psr
          exit
        end

        psr.on("validate", "Validate definitions with renovate provided tool") do
          validate = true
        end
        psr.on("lint", "Lint definitions") do
          lint = true
        end
        psr.on("scaffold", "Generate files for first step of adding new plugins") do
          scaffold = true
          psr.on("--plugin=NAME", "Specify plugin name") { |_plugin| plugin = _plugin }
        end
        psr.on("release", "Add git tags in default.json") do
          release = true
          psr.on("--version=VERSION", "Specify new version") { |_version| version = _version }
        end
      end

      parser.parse(args)

      case
      when validate
        success, message = RenovateConfigAsdf::Validator.validate(globs: %w[plugins/*.json* renovate.json default.json])
        raise(message) unless success
      when lint
        success, message = RenovateConfigAsdf::Linter.lint_default_json("default.json")
        raise(message) unless success
        success, message = RenovateConfigAsdf::Linter.lint_example("examples/.tool-versions")
        raise(message) unless success
      when scaffold
        raise "Require to specify plugin name" if plugin == ""
        RenovateConfigAsdf::Scaffolder.write(plugin)
      when release
        raise "Require to specify new version" if version == ""
        RenovateConfigAsdf::ReleaseManager.release(version)
      else
        puts parser
        exit(1)
      end
    end
  end
end
