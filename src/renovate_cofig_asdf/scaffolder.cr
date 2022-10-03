#! /usr/bin/env crystal

require "ecr"
require "json"

module RenovateConfigAsdf
  class Scaffolder
    RENOVATE_JSON_PATH         = "renovate.json"
    DEAFULT_JSON_PATH          = "default.json"
    EXAMPLE_TOOL_VERSIONS_PATH = "examples/.tool-versions"

    def initialize(@plugin : String)
    end

    ECR.def_to_s("#{__DIR__}/plugin-template.json5.ecr")

    def self.scaffold(plugin : String) : String
      new(plugin).to_s
    end

    def self.merge_entries(entries : Array(String), inserting : String) : Array(String)
      position = entries.index { |entry| entry > inserting }
      position ||= entries.size
      [*entries[0, position], inserting, *entries[position, entries.size]]
    end

    def self.updated_defaullt_json(origin : String, plugin : String) : String
      json = Hash(String, String | Array(String)).from_json(origin)
      entries = json["extends"]
      raise "Unexpected schema of JSON" unless entries.is_a?(Array(String))
      new_entry = "local>kachick/renovate-config-asdf//plugins/#{plugin}.json5"
      json["extends"] = merge_entries(entries, new_entry)
      json.to_json
    end

    def self.updated_example(origin : String, plugin : String) : String
      entires = origin.lines(chomp: false)
      merge_entries(entires, "#{plugin} <UPDATEME!>\n").join
    end

    def self.touched_renovate_json(origin : String) : String
      origin.sub(/"ignore-this-label-just-for-trigger-renovate-(\S+?)"/, %Q("ignore-this-label-just-for-trigger-renovate-#{Random.new.hex[0, 6]}"))
    end

    def self.write(plugin : String)
      config = scaffold(plugin)
      new_json = updated_defaullt_json(File.read(DEAFULT_JSON_PATH), plugin)
      new_example = updated_example(File.read(EXAMPLE_TOOL_VERSIONS_PATH), plugin)
      new_renovate_json = touched_renovate_json(File.read(RENOVATE_JSON_PATH))

      File.write("plugins/#{plugin}.json5", config)
      File.write(DEAFULT_JSON_PATH, new_json)
      File.write(EXAMPLE_TOOL_VERSIONS_PATH, new_example)
      File.write(RENOVATE_JSON_PATH, new_renovate_json)
    end
  end
end
