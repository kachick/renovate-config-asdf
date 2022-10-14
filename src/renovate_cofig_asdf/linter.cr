#! /usr/bin/env crystal

require "json"

module RenovateConfigAsdf
  module Linter
    def self.lint_plugins_list(plugins : Array(String), reference : Array(String)) : Tuple(Bool, String)
      is_plugins_uniq = plugins.uniq == plugins
      return {is_plugins_uniq, "Examples are duplicated"} unless is_plugins_uniq

      is_plugins_sorted = plugins.sort == plugins
      return {is_plugins_sorted, "Examples are not sorted"} unless is_plugins_sorted

      missing_plugins = reference - plugins
      is_linked_plugins = missing_plugins.empty?
      return {is_linked_plugins, "Some plugins are not linked: #{missing_plugins.sort.inspect}"} unless is_linked_plugins

      {true, "Everything OK :)"}
    end

    def self.lint_default_json(path : String, reference : Array(String)) : Tuple(Bool, String)
      json = RenovateConfigAsdf::DefaultJson.from_json(File.read(path))
      entries = json["extends"]
      return {false, "Unexpected JSON schema"} unless entries.is_a?(Array(String))
      plugins = entries.map(&.[%r<plugins/([^/]+)\.json5\z>, 1])
      lint_plugins_list(plugins, reference)
    end

    def self.lint_example(path : String, reference : Array(String)) : Tuple(Bool, String)
      entries = File.read_lines(path)
      plugins = entries.map(&.split(' ').first)
      lint_plugins_list(plugins, reference)
    end
  end
end
