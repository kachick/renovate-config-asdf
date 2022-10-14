#! /usr/bin/env crystal

require "./renovate_config_asdf"

RenovateConfigAsdf::Cli.new(STDOUT).run(ARGV)
