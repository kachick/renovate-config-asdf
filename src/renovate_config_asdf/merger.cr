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

    def self.write
      default_json = RootConfig.from_json(File.read(DEFAULT_JSON_PATH))
      plugins_jsons = RenovateConfigAsdf.defined_plugin_files(only_basename: false).map { |path| PluginConfig.from_json(roughly_strip_json5_comments(File.read(path))) }
      File.write(DEFAULT_JSON_PATH, merge(default_json, plugins_jsons).to_json)
    end

    # crystal does not have JSONC parser. This is an ugly workaround
    def self.roughly_strip_json5_comments(json5 : String) : String
      json5.gsub(%r[^\s+// .+?\n]m, "")
    end
  end
end
