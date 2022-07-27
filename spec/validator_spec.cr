require "./spec_helper"

describe RenovateConfigAsdf::Validator do
  it "returns success for empty globs" do
    success, message = RenovateConfigAsdf::Validator.validate(%w[])
    success.should eq(true)
  end

  it "returns success for actual globs" do
    success, message = RenovateConfigAsdf::Validator.validate(%w[default.json])
    success.should eq(true)
  end

  it "returns false for invalid definiton" do
    success, message = RenovateConfigAsdf::Validator.validate(%w[spec/fixtures/ruby-invalid.json5])
    success.should eq(false)
    message.should contain("spec/fixtures/ruby-invalid.json5 has incorrect definitions")
  end
end
