require "./spec_helper"

require "json"

describe RenovateConfigAsdf::Scaffolder do
  describe ".scaffold" do
    it "generates JSON from given plugin name" do
      scaffold = RenovateConfigAsdf::Scaffolder.scaffold("foobar")
      scaffold.should contain("depNameTemplate\": \"owner/foobar")
    end
  end

  describe ".merge_entries" do
    it "returns new array that inserts given entry into correct position" do
      entires = %w(bun crystal ruby)
      RenovateConfigAsdf::Scaffolder.merge_entries(entires, "deno").should eq(%w(bun crystal deno ruby))
    end

    it "does not touch base entries" do
      entires = %w(bun crystal ruby)
      RenovateConfigAsdf::Scaffolder.merge_entries(entires, "deno")
      entires.should eq(%w(bun crystal ruby))
    end

    it "works even if given entry will be first position" do
      entires = %w(crystal ruby)
      RenovateConfigAsdf::Scaffolder.merge_entries(entires, "bun").should eq(%w(bun crystal ruby))
    end

    it "works even if given entry will be last position" do
      entires = %w(bun crystal)
      RenovateConfigAsdf::Scaffolder.merge_entries(entires, "ruby").should eq(%w(bun crystal ruby))
    end
  end

  describe ".updated_example" do
    it "returns inserted string into correct position" do
      origin = <<-ASDF
      crystal 1.5.1
      deno 1.25.3
      rust 1.63.0
      ASDF

      expected = <<-ASDF
      crystal 1.5.1
      deno 1.25.3
      ruby <UPDATEME!>
      rust 1.63.0
      ASDF

      RenovateConfigAsdf::Scaffolder.updated_example(origin, "ruby").should eq(expected)
    end
  end

  describe ".touched_renovate_json" do
    it "returns string that toggled with rand suffix label" do
      origin = <<-'JSON'
      {
        "$schema": "https://docs.renovatebot.com/renovate-schema.json",
        "dependencyDashboard": true,
        "extends": [
          "config:base",
          "github>kachick/renovate-config-dprint:plugins",
          "local>kachick/renovate-config-asdf"
        ],
        "labels": [
          "renovate",
          "dependencies",
          "ignore-this-label-just-for-trigger-renovate-97fbb3"
        ]
      }
      JSON

      result = RenovateConfigAsdf::Scaffolder.touched_renovate_json(origin)
      result.should_not match(/"ignore-this-label-just-for-trigger-renovate-97fbb3"/)
      result.should match(/"ignore-this-label-just-for-trigger-renovate-[0-9a-z]{6}"/)
    end
  end
end
