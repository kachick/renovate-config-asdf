module RenovateConfigAsdf
  module Validator
    def self.validate(globs : Array(String)) : Tuple(Bool, String)
      Dir.glob(globs).each do |path|
        status = Process.run(env: ENV.to_h.merge({"RENOVATE_CONFIG_FILE" => path}), command: "npx", args: ["renovate-config-validator"], output: STDOUT)
        return({false, "#{path} has incorrect definitions"}) unless status.success?
      end
      {true, "No error found"}
    end
  end
end

if ARGV.size >= 1 && ARGV.first == "run"
  success, message = RenovateConfigAsdf::Validator.validate(globs: %w[plugins/*.json* renovate.json default.json])
  raise(message) unless success
end
