#! /usr/bin/env crystal

require "./renovate_cofig_asdf"

RenovateConfigAsdf::Cli.new(STDOUT).run(ARGV)
