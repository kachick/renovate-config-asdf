#! /usr/bin/env crystal

module RenovateConfigAsdf
  module Validator
    def self.validate(globs : Array(String), command : String = "npx", args : Array(String) = ["renovate-config-validator"]) : Tuple(Bool, String)
      processes = Dir.glob(globs).to_h do |path|
        sleep(0.5)
        {path, Process.new(env: ENV.to_h.merge({"RENOVATE_CONFIG_FILE" => path}), command: command, args: args, output: STDOUT, error: STDERR)}
      end
      failures = processes.reject do |_path, process|
        status = process.wait
        status.success?
      end
      failures.empty? ? {true, "No error found"} : {false, "#{failures.keys.join(", ")} has incorrect definitions"}
    end
  end
end
