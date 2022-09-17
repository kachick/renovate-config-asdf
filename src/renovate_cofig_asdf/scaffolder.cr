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

    def self.insert_entry(entries : Array(String), inserting : String) : Array(String)
      position = entries.index { |entry| entry > inserting }
      position ||= entries.size
      [*entries[0, position], inserting, *entries[position, entries.size]]
    end

    def self.write(plugin : String)
      json = Hash(String, String | Array(String)).from_json(File.read("default.json"))
      entries = json["extends"]
      raise "Unexpected schema of JSON" unless entries.is_a?(Array(String))
      new_entry = "local>kachick/renovate-config-asdf//plugins/#{plugin}.json5"
      json["extends"] = insert_entry(entries, new_entry)

      File.write("plugins/#{plugin}.json5", scaffold(plugin))
      File.write("default.json", json.to_json)
    end
  end
end
