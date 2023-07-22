require "./spec_helper"

describe RenovateConfigAsdf::Validator do
  context "with mock execution" do
    it "passes RENOVATE_CONFIG_FILE as an ENV" do
      success, _message = RenovateConfigAsdf::Validator.validate(%w[default.json], command: "spec/fixtures/mock-validator.bash")
      success.should eq(true)
    end
  end

  context "with actual npm command", tags: "needs_npm" do
    it "returns true for empty globs" do
      success, _message = RenovateConfigAsdf::Validator.validate(%w[])
      success.should eq(true)
    end

    it "returns true for actual globs" do
      success, _message = RenovateConfigAsdf::Validator.validate(%w[default.json])
      success.should eq(true)
    end

    it "returns false for invalid definition" do
      success, message = RenovateConfigAsdf::Validator.validate(%w[spec/fixtures/ruby-invalid.json5])
      success.should eq(false)
      message.should contain("spec/fixtures/ruby-invalid.json5 has incorrect definitions")
    end
  end
end
