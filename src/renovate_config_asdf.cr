require "./renovate_config_asdf/*"

module RenovateConfigAsdf
  alias DefaultJson = Hash(String, String | Array(String))

  RENOVATE_JSON_PATH         = "renovate.json"
  DEAFULT_JSON_PATH          = "default.json"
  EXAMPLE_TOOL_VERSIONS_PATH = "examples/.tool-versions"

  def self.defined_plugin_files : Array(String)
    Dir.entries("plugins").reject { |basename| basename == "." || basename == ".." }
  end

  def self.defined_plugins : Array(String)
    plugins = defined_plugin_files.compact_map(&.[%r<([\S]+)\.json5\z>, 1]?)
    raise "no plugins found" if plugins.empty?
    plugins
  end
end
