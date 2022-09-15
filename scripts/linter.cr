#! /usr/bin/env crystal

module RenovateConfigAsdf
  module Linter
    def self.lint(path : String) : Tuple(Bool, String)
      entries = File.read_lines(path)
      plugins = entries.map(&.split(' ').first)

      is_plugins_uniq = plugins.uniq == plugins
      return {is_plugins_uniq, "Examples are duplicated"} unless is_plugins_uniq

      is_plugins_sorted = plugins.sort == plugins
      return {is_plugins_sorted, "Examples are not sorted"} unless is_plugins_sorted

      {true, "Everything OK :)"}
    end
  end
end

if ARGV.size >= 1 && ARGV.first == "run"
  success, message = RenovateConfigAsdf::Linter.lint("examples/.tool-versions")
  raise(message) unless success
end
