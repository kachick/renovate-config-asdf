#! /usr/bin/env crystal

require "./renovate_cofig_asdf/cli"

RenovateConfigAsdf::Cli.new(STDOUT).run(ARGV)
