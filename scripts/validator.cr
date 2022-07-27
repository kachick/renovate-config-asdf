Dir.glob(%w[plugins/*.json* renovate.json default.json]).map do |config_path|
  status = Process.run(env: ENV.to_h.merge({"RENOVATE_CONFIG_FILE" => config_path}), command: "npx", args: ["renovate-config-validator"], output: STDOUT)
  raise "#{config_path} has incorrect definitions" unless status.success?
end
