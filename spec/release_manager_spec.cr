require "./spec_helper"

private def original_default_json
  <<-JSON
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
end

describe RenovateConfigAsdf::ReleaseManager do
  describe ".version?" do
    it "returns true when given a numbers delimited format like a simple semantic versioning" do
      RenovateConfigAsdf::ReleaseManager.version?("0.4.2").should eq(true)
    end

    it "returns false when given string contains non numbers" do
      RenovateConfigAsdf::ReleaseManager.version?("0.4.2.pre").should eq(false)
      RenovateConfigAsdf::ReleaseManager.version?("0.4.x").should eq(false)
    end
  end

  describe ".release" do
    it "raises ArgumentError when given an incorrect version" do
      expect_raises(ArgumentError) do
        RenovateConfigAsdf::ReleaseManager.release("0.4.x")
      end
    end
  end

  describe ".releasing_json" do
    it "raises ArgumentError when given an incorrect version" do
      expect_raises(ArgumentError) do
        RenovateConfigAsdf::ReleaseManager.releasing_json(original_default_json, "0.4.x")
      end
    end

    it "returns replaced JSON with given version" do
      RenovateConfigAsdf::DefaultJson.from_json(RenovateConfigAsdf::ReleaseManager.releasing_json(original_default_json, "1.5.0")).should eq(
        RenovateConfigAsdf::DefaultJson.from_json(
          <<-JSON
          {
            "$schema": "https://docs.renovatebot.com/renovate-schema.json",
            "description": "Sharable config for .tool-version with asdf",
            "extends": [
              "github>kachick/renovate-config-asdf//plugins/crystal.json5#1.5.0",
              "github>kachick/renovate-config-asdf//plugins/deno.json5#1.5.0",
              "github>kachick/renovate-config-asdf//plugins/rust.json5#1.5.0"
            ]
          }
          JSON
        )
      )
    end
  end
end
