#! /usr/bin/env crystal

require "ecr"
require "json"

module RenovateConfigAsdf
  class Scaffolder
    def initialize(@plugin : String)
    end

    ECR.def_to_s("#{__DIR__}/plugin-template.json5.ecr")

    def self.scaffold(plugin : String) : String
      new(plugin).to_s
    end

    def self.merge_entries(entries : Array(String), inserting : String) : Array(String)
      position = entries.index { |entry| entry > inserting } || entries.size
      [*entries[0, position], inserting, *entries[position, entries.size]]
    end

    def self.updated_example(origin : String, plugin : String) : String
      entires = origin.lines(chomp: false)
      merge_entries(entires, "#{plugin} <UPDATEME!>\n").join
    end

    def self.touched_renovate_json(origin : String) : String
      origin.sub(/"ignore-this-label-just-for-trigger-renovate-(\S+?)"/, %Q("ignore-this-label-just-for-trigger-renovate-#{Random.new.hex[0, 6]}"))
    end

    def self.touch : Void
      File.write(
        RENOVATE_JSON_PATH,
        touched_renovate_json(File.read(RENOVATE_JSON_PATH))
      )
    end

    def self.write(plugin : String) : Void
      config = scaffold(plugin)
      new_example = updated_example(File.read(EXAMPLE_TOOL_VERSIONS_PATH), plugin)

      File.write("plugins/#{plugin}.json5", config)
      File.write(EXAMPLE_TOOL_VERSIONS_PATH, new_example)
      touch
    end
  end
end
