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

  describe ".updated_defaullt_json" do
    json_format = Hash(String, String | Array(String))

    it "returns inserted JSON into correct position it is might be unformatted" do
      origin = <<-JSON
      {
        "$schema": "https://docs.renovatebot.com/renovate-schema.json",
        "description": "Sharable config for .tool-version with asdf",
        "extends": [
          "local>kachick/renovate-config-asdf//plugins/crystal.json5",
          "local>kachick/renovate-config-asdf//plugins/deno.json5",
          "local>kachick/renovate-config-asdf//plugins/rust.json5"
        ]
      }
      JSON

      expected = <<-JSON
      {
        "$schema": "https://docs.renovatebot.com/renovate-schema.json",
        "description": "Sharable config for .tool-version with asdf",
        "extends": [
          "local>kachick/renovate-config-asdf//plugins/crystal.json5",
          "local>kachick/renovate-config-asdf//plugins/deno.json5",
          "local>kachick/renovate-config-asdf//plugins/ruby.json5",
          "local>kachick/renovate-config-asdf//plugins/rust.json5"
        ]
      }
      JSON

      json_format.from_json(RenovateConfigAsdf::Scaffolder.updated_defaullt_json(origin, "ruby")).should eq(json_format.from_json(expected))
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
end
