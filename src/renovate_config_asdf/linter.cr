#! /usr/bin/env crystal

require "json"

module RenovateConfigAsdf
  module Linter
    def self.lint_plugins_list(plugins : Array(String), reference : Array(String)) : Tuple(Bool, String)
      plugin_to_count = plugins.tally
      # scala has special definition for v2 and v3
      duplicated_plugins = plugin_to_count.select { |plugin, count| count > 1 && plugin != "scala" }
      is_plugins_uniq = duplicated_plugins.empty?
      return {is_plugins_uniq, "Examples are duplicated: #{duplicated_plugins}"} unless is_plugins_uniq

      is_plugins_sorted = plugins.sort == plugins
      return {is_plugins_sorted, "Examples are not sorted"} unless is_plugins_sorted

      missing_plugins = reference - plugins
      is_linked_plugins = missing_plugins.empty?
      return {is_linked_plugins, "Some plugins are not linked: #{missing_plugins.sort.inspect}"} unless is_linked_plugins

      {true, "Everything OK :)"}
    end

    def self.lint_default_json(path : String, reference : Array(String)) : Tuple(Bool, String)
      json = RootConfig.from_json(File.read(path))
      regex_managers = json.regexManagers
      return {false, "Unexpected JSON schema"} unless regex_managers
      patterns = regex_managers.flat_map(&.matchStrings)
      plugins = patterns.compact_map(&.[%r<\)(\S+)\s>, 1]?)
      return {false, "no entries found"} if plugins.empty?
      lint_plugins_list(plugins, reference)
    end

    def self.lint_example(path : String, reference : Array(String)) : Tuple(Bool, String)
      entries = File.read_lines(path)
      plugins = entries.map(&.split(' ').first)
      lint_plugins_list(plugins, reference)
    end
  end
end
