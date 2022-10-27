require "json"

module RenovateConfigAsdf
  @[JSON::Serializable::Options(emit_nulls: true)]
  class RegexManagerConfig
    include JSON::Serializable

    property fileMatch : Array(String)
    property matchStrings : Array(String)
    property depNameTemplate : String
    property datasourceTemplate : String
    property versioningTemplate : String?
    property extractVersionTemplate : String?
  end

  @[JSON::Serializable::Options(emit_nulls: true)]
  class RootConfig
    include JSON::Serializable

    @[JSON::Field(key: "$schema", emit_null: true)]
    getter schema : String?

    property description : String
    property extends : Array(String)?
    property regexManagers : Array(RegexManagerConfig)?
  end

  @[JSON::Serializable::Options(emit_nulls: true)]
  class PluginConfig
    include JSON::Serializable

    @[JSON::Field(key: "$schema", emit_null: true)]
    getter schema : String?

    property description : String
    property regexManagers : Array(RegexManagerConfig)
  end
end
