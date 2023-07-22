require "./renovate_config_asdf/*"

module RenovateConfigAsdf
  RENOVATE_JSON_PATH         = "renovate.json"
  DEFAULT_JSON_PATH          = "default.json"
  EXAMPLE_TOOL_VERSIONS_PATH = "examples/.tool-versions"

  def self.defined_plugin_files(only_basename : Bool = true) : Array(String)
    basenames = Dir.entries("plugins").reject { |basename| basename == "." || basename == ".." }.sort!
    only_basename ? basenames : basenames.map { |basename| "plugins/#{basename}" }
  end

  def self.defined_plugins : Array(String)
    plugins = defined_plugin_files.compact_map(&.[%r<([\S]+)\.json5\z>, 1]?)
    raise "no plugins found" if plugins.empty?
    plugins
  end
end
