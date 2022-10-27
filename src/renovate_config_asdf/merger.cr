#! /usr/bin/env crystal

module RenovateConfigAsdf
  module Merger
    def self.merge(default_json : RootConfig, plugins_jsons : Array(PluginConfig)) : RootConfig
      plugin_regex_managers = plugins_jsons.flat_map(&.regexManagers)
      ret = default_json.dup
      ret.regexManagers = plugin_regex_managers
      ret.extends = nil
      ret
    end

    # crystal does not have JSONC parser. This is an ugly workaround
    def self.roughly_strip_json5_comments(json5 : String) : String
      json5.gsub(%r[^\s+// .+?\n]m, "")
    end
  end
end
