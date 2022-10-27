require "json"

module RenovateConfigAsdf
  class GitHhubActionsHelper
    def self.generate_matrix(text : String, chunk_size : UInt16) : String
      lines = text.lines.map(&.chomp)
      raise ArgumentError.new("given text having unexpected whitespaces") if lines.any? { |line| /\s/.matches?(line) }
      lines.each_slice(chunk_size).map(&.join(" ")).to_json
    end
  end
end
