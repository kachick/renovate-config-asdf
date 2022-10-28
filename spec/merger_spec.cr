require "./spec_helper"

private def merger
  RenovateConfigAsdf::Merger
end

private def default_json
  <<-'JSON'
  {
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    "description": "Sharable config for .tool-versions(asdf)",
    "extends": [
      "local>kachick/renovate-config-asdf//plugins/clojure.json5",
      "local>kachick/renovate-config-asdf//plugins/gauche.json5",
      "local>kachick/renovate-config-asdf//plugins/scala.json5"
    ]
  }
  JSON
end

private def gauche_json5
  <<-'JSON5'
  {
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    "description": "Bump gauche in .tool-versions",
    "regexManagers": [
      {
        "fileMatch": ["\\.tool-versions$"],
        "matchStrings": ["(^|\\n)gauche (?<currentValue>\\S+)"],
        // https://github.com/shirok/Gauche/releases
        // https://github.com/sakuro/asdf-gauche/blob/71f574d7c934bc4977eec4fb8005e2ecd0d7ed0c/bin/list-all#L5
        // https://regex101.com/r/L2micV
        // Working but _ delimter snapshot is commentouted
        // "datasourceTemplate": "github-tags",
        // "extractVersionTemplate": "^release(?<version>\\S+)",
        // "versioningTemplate": "regex:^(?<major>\\d+?)[_.](?<minor>\\d+?)[_.](?<patch>\\d+)$"
        // So using docker tags
        "depNameTemplate": "practicalscheme/gauche",
        "datasourceTemplate": "docker"
      }
    ]
  }
  JSON5
end

private def plugin_jsons : Array(RenovateConfigAsdf::PluginConfig)
  clojure_json5 = <<-'JSON5'
  {
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    "description": "Bump clojure in .tool-versions",
    "regexManagers": [
      {
        "fileMatch": ["\\.tool-versions$"],
        "matchStrings": ["(^|\\n)clojure (?<currentValue>\\S+)"],
        // https://github.com/clojure/brew-install/tags
        "depNameTemplate": "clojure/brew-install",
        "datasourceTemplate": "github-tags",
        "versioningTemplate": "regex:^(?<major>\\d+?)\\.(?<minor>\\d+?)\\.(?<patch>\\d+)\\.(?<build>\\d+)$"
      }
    ]
  }
  JSON5

  scala_json5 = <<-'JSON5'
  {
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    "description": "Bump scala in .tool-versions",
    "regexManagers": [
      {
        "fileMatch": ["\\.tool-versions$"],
        "matchStrings": ["(^|\\n)scala (?<currentValue>2\\..+?)\\n"],
        // https://github.com/scala/scala/tags
        "depNameTemplate": "scala/scala",
        "datasourceTemplate": "github-tags",
        "extractVersionTemplate": "^v(?<version>\\S+)"
      },
      {
        "fileMatch": ["\\.tool-versions$"],
        "matchStrings": ["(^|\\n)scala (?<currentValue>3\\..+?)\\n"],
        // https://github.com/lampepfl/dotty/tags
        "depNameTemplate": "lampepfl/dotty",
        "datasourceTemplate": "github-tags"
      }
    ]
  }
  JSON5

  [clojure_json5, gauche_json5, scala_json5].map { |json5| RenovateConfigAsdf::PluginConfig.from_json(merger.roughly_strip_json5_comments(json5)) }
end

describe RenovateConfigAsdf::Merger do
  describe "configs" do
    it "raises an error when given a json5(JSONC)" do
      expect_raises(JSON::SerializableError) do
        RenovateConfigAsdf::PluginConfig.from_json(gauche_json5)
      end
    end
  end

  describe ".merge" do
    it "returns merged json" do
      merger.merge(RenovateConfigAsdf::RootConfig.from_json(default_json), plugin_jsons).to_json.should eq(
        RenovateConfigAsdf::RootConfig.from_json(
          <<-'JSON'
          {
            "$schema": "https://docs.renovatebot.com/renovate-schema.json",
            "description": "Sharable config for .tool-versions(asdf)",
            "regexManagers": [
              {
                "fileMatch": ["\\.tool-versions$"],
                "matchStrings": ["(^|\\n)clojure (?<currentValue>\\S+)"],
                "depNameTemplate": "clojure/brew-install",
                "datasourceTemplate": "github-tags",
                "versioningTemplate": "regex:^(?<major>\\d+?)\\.(?<minor>\\d+?)\\.(?<patch>\\d+)\\.(?<build>\\d+)$"
              },
              {
                "fileMatch": ["\\.tool-versions$"],
                "matchStrings": ["(^|\\n)gauche (?<currentValue>\\S+)"],
                "depNameTemplate": "practicalscheme/gauche",
                "datasourceTemplate": "docker"
              },
              {
                "fileMatch": ["\\.tool-versions$"],
                "matchStrings": ["(^|\\n)scala (?<currentValue>2\\..+?)\\n"],
                "depNameTemplate": "scala/scala",
                "datasourceTemplate": "github-tags",
                "extractVersionTemplate": "^v(?<version>\\S+)"
              },
              {
                "fileMatch": ["\\.tool-versions$"],
                "matchStrings": ["(^|\\n)scala (?<currentValue>3\\..+?)\\n"],
                "depNameTemplate": "lampepfl/dotty",
                "datasourceTemplate": "github-tags"
              }
            ]
          }
          JSON
        ).to_json
      )
    end
  end

  describe ".roughly_strip_json5_comments" do
    it "strips comments" do
      merger.roughly_strip_json5_comments(gauche_json5).should eq(
        <<-'JSON'
      {
        "$schema": "https://docs.renovatebot.com/renovate-schema.json",
        "description": "Bump gauche in .tool-versions",
        "regexManagers": [
          {
            "fileMatch": ["\\.tool-versions$"],
            "matchStrings": ["(^|\\n)gauche (?<currentValue>\\S+)"],
            "depNameTemplate": "practicalscheme/gauche",
            "datasourceTemplate": "docker"
          }
        ]
      }
      JSON
      )
    end

    it "can not strip comments when it is trailing to the line ending", tags: "wantfix" do
      merger.roughly_strip_json5_comments(
        <<-'JSON5'
        {
          {
            "$schema": "https://docs.renovatebot.com/renovate-schema.json",
            "description": "Bump gauche in .tool-versions",
            "regexManagers": [
              {
                "fileMatch": ["\\.tool-versions$"], # This pattern can not be parsed
                "matchStrings": ["(^|\\n)gauche (?<currentValue>\\S+)"],
                "depNameTemplate": "practicalscheme/gauche",
                "datasourceTemplate": "docker"
              }
            ]
          }
        }
        JSON5
      ).should_not eq(
        <<-'JSON'
        {
          "$schema": "https://docs.renovatebot.com/renovate-schema.json",
          "description": "Bump gauche in .tool-versions",
          "regexManagers": [
            {
              "fileMatch": ["\\.tool-versions$"],
              "matchStrings": ["(^|\\n)gauche (?<currentValue>\\S+)"],
              "depNameTemplate": "practicalscheme/gauche",
              "datasourceTemplate": "docker"
            }
          ]
        }
        JSON
      )
    end
  end
end
