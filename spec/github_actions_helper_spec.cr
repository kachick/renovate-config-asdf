require "./spec_helper"

require "json"

private def helper
  RenovateConfigAsdf::GitHhubActionsHelper
end

describe RenovateConfigAsdf::GitHhubActionsHelper do
  describe ".generate_matrix" do
    it "generates chunked json array" do
      helper.generate_matrix("foo\nbar\nbaz", 1).should eq(["foo", "bar", "baz"].to_json)
      helper.generate_matrix("foo\nbar\nbaz", 2).should eq(["foo bar", "baz"].to_json)
      helper.generate_matrix("foo\nbar\nbaz", 3).should eq(["foo bar baz"].to_json)
    end

    it "raises an error when given string contains whitespace" do
      expect_raises(ArgumentError) do
        helper.generate_matrix("foo\nba r\nbaz", 1)
      end
    end
  end
end
