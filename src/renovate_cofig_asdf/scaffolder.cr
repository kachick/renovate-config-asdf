#! /usr/bin/env crystal

require "ecr"
require "json"

module RenovateConfigAsdf
  class Scaffolder
    DEAFULT_JSON_PATH = "default.json"
    EXAMPLE_TOOL_VERSIONS_PATH = "examples/.tool-versions"

    def initialize(@plugin : String)
    end

    ECR.def_to_s("#{__DIR__}/plugin-template.json5.ecr")

    def self.scaffold(plugin : String) : String
      new(plugin).to_s
    end

    def self.insert_entry(entries : Array(String), inserting : String) : Array(String)
      position = entries.index { |entry| entry > inserting }
      position ||= entries.size
      [*entries[0, position], inserting, *entries[position, entries.size]]
    end

    def self.updated_defaullt_json(plugin : String, origin : String) : String
      json = Hash(String, String | Array(String)).from_json(origin)
      entries = json["extends"]
      raise "Unexpected schema of JSON" unless entries.is_a?(Array(String))
      new_entry = "local>kachick/renovate-config-asdf//plugins/#{plugin}.json5"
      json["extends"] = insert_entry(entries, new_entry)
      json.to_json
    end

    def self.updated_example(plugin : String, origin : String) : String
      entires = origin.lines(chomp: false)
      insert_entry(entires, "#{plugin} <UPDATEME!>\n").join
    end

    def self.write(plugin : String)
      config = scaffold(plugin)
      new_json = updated_defaullt_json(plugin, File.read(DEAFULT_JSON_PATH))
      new_example = updated_example(plugin, File.read(EXAMPLE_TOOL_VERSIONS_PATH))

      File.write("plugins/#{plugin}.json5", config)
      File.write(DEAFULT_JSON_PATH, new_json)
      File.write(EXAMPLE_TOOL_VERSIONS_PATH, new_example)
    end
  end
end
