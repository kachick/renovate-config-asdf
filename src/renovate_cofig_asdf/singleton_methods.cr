module RenovateConfigAsdf
  def self.defined_plugin_files : Array(String)
    Dir.entries("plugins").reject { |basename| basename == "." || basename == ".." }
  end

  def self.defined_plugins : Array(String)
    defined_plugin_files.map(&.[%r<([\S]+)\.json5\z>, 1])
  end
end
