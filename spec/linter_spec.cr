require "./spec_helper"

describe RenovateConfigAsdf::Linter do
  it "returns true for actual example" do
    success, _message = RenovateConfigAsdf::Linter.lint("examples/.tool-versions")
    success.should eq(true)
  end

  it "returns false for duplicated entries" do
    success, message = RenovateConfigAsdf::Linter.lint("spec/fixtures/.tool-versions-invalid-duplicated")
    success.should eq(false)
    message.should contain("Examples are duplicated")
  end

  it "returns false for unsorted entries" do
    success, message = RenovateConfigAsdf::Linter.lint("spec/fixtures/.tool-versions-invalid-unsorted")
    success.should eq(false)
    message.should contain("Examples are not sorted")
  end
end
