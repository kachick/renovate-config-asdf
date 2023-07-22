#! /usr/bin/env crystal

require "option_parser"

require "./*"

module RenovateConfigAsdf
  class Cli
    def initialize(@io : IO = STDOUT)
    end

    def run(args : Array(String))
      validate = false
      lint = false
      scaffold = false
      release = false
      touch = false
      merge = false
      plugin = ""
      version = ""
      help = false

      globs : Array(String) = ["plugins/*.json*", RENOVATE_JSON_PATH, DEFAULT_JSON_PATH]

      generate_matrix = false
      matrix_chunk_size : UInt16 = 2

      parser = OptionParser.new do |psr|
        psr.banner = "Usage: [arguments]"
        psr.on("-h", "--help", "Show this help") do
          help = true
        end

        psr.on("validate", "Validate definitions with renovate provided tool") do
          validate = true
          psr.on("--globs='globs'", "File globs separated by a whitespace") { |_globs| globs = _globs.split }
        end
        psr.on("lint", "Lint definitions") do
          lint = true
        end
        psr.on("scaffold", "Generate files for first step of adding new plugins") do
          scaffold = true
          psr.on("--plugin=NAME", "Plugin name") { |_plugin| plugin = _plugin }
        end
        psr.on("release", "Add git tags in default.json") do
          release = true
          psr.on("--version=VERSION", "New version") { |_version| version = _version }
        end
        psr.on("touch", "Update renovate.json labels to toriger renovate") do
          touch = true
        end
        psr.on("merge", "Update default.json from plugins/* definitions") do
          merge = true
        end
        psr.on("generate_matrix", "Generate matrix JSON from STDIN for GitHub Actions") do
          generate_matrix = true
          psr.on("--matrix_chunk_size=NUMBER", "Number of chunk size") { |number| matrix_chunk_size = number.to_u16(10) }
        end
      end

      parser.parse(args)

      case
      when help
        @io.puts(parser)
      when validate
        success, message = Validator.validate(globs: globs)
        raise(message) unless success
      when lint
        defined_plugins = RenovateConfigAsdf.defined_plugins
        success, message = Linter.lint_default_json(DEFAULT_JSON_PATH, defined_plugins)
        raise(message) unless success
        success, message = Linter.lint_example(EXAMPLE_TOOL_VERSIONS_PATH, defined_plugins)
        raise(message) unless success
      when scaffold
        raise "Require to specify plugin name" if plugin == ""
        Scaffolder.write(plugin)
      when release
        raise "Require to specify new version" if version == ""
        ReleaseManager.release(version)
      when touch
        Scaffolder.touch
      when merge
        Merger.write
        `dprint fmt #{DEFAULT_JSON_PATH}`
      when generate_matrix
        print GitHhubActionsHelper.generate_matrix(STDIN.gets_to_end, matrix_chunk_size)
      else
        @io.puts(parser)
        exit(1)
      end
    end
  end
end
