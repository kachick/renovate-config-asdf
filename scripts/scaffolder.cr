#! /usr/bin/env crystal

require "ecr"
require "json"

module RenovateConfigAsdf
  class Scaffolder
    def initialize(@plugin : String)
    end

    ECR.def_to_s("scripts/plugin-template.json5.ecr")

    def self.scaffold(plugin : String) : String
      new(plugin).to_s
    end

    def self.write(plugin : String)
      json = Hash(String, String | Array(String)).from_json(File.read("default.json"))
      entries = json["extends"]
      raise "Unexpected schema of JSON" unless entries.is_a?(Array(String))
      new_entry = "local>kachick/renovate-config-asdf//plugins/#{plugin}.json5"

      new_position = entries.index { |entry| entry > new_entry }
      raise "Unexpected entries exist" unless new_position
      entries.insert(new_position, new_entry)
      json["extends"] = entries

      File.write("plugins/#{plugin}.json5", scaffold(plugin))
      File.write("default.json", json.to_json)
    end
  end
end

if ARGV.size >= 2 && ARGV.first == "run"
  RenovateConfigAsdf::Scaffolder.write(ARGV[1])
end
