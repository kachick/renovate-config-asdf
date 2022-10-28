require "json"

module RenovateConfigAsdf
  class RegexManagerConfig
    include JSON::Serializable

    property fileMatch : Array(String)
    property matchStrings : Array(String)
    property depNameTemplate : String
    property datasourceTemplate : String
    property versioningTemplate : String?
    property extractVersionTemplate : String?
  end

  class RootConfig
    include JSON::Serializable

    @[JSON::Field(key: "$schema")]
    getter schema : String?

    property description : String
    property extends : Array(String)?
    property regexManagers : Array(RegexManagerConfig)?
  end

  class PluginConfig
    include JSON::Serializable

    @[JSON::Field(key: "$schema")]
    getter schema : String?

    property description : String
    property regexManagers : Array(RegexManagerConfig)
  end
end
