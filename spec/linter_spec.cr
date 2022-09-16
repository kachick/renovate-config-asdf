require "./spec_helper"

describe RenovateConfigAsdf::Linter do
  describe ".lint_example" do
    it "returns true for actual example" do
      success, _message = RenovateConfigAsdf::Linter.lint_example("examples/.tool-versions")
      success.should eq(true)
    end

    it "returns false for duplicated entries" do
      success, message = RenovateConfigAsdf::Linter.lint_example("spec/fixtures/.tool-versions-invalid-duplicated")
      success.should eq(false)
      message.should contain("Examples are duplicated")
    end

    it "returns false for unsorted entries" do
      success, message = RenovateConfigAsdf::Linter.lint_example("spec/fixtures/.tool-versions-invalid-unsorted")
      success.should eq(false)
      message.should contain("Examples are not sorted")
    end
  end

  describe ".lint_default_json" do
    it "returns true for actual example" do
      success, _message = RenovateConfigAsdf::Linter.lint_default_json("default.json")
      success.should eq(true)
    end

    it "returns false for missing entries" do
      success, message = RenovateConfigAsdf::Linter.lint_default_json("spec/fixtures/default-invalid-missing.json")
      success.should eq(false)
      message.should contain("Some plugins are not linked: [\"erlang\", \"nodejs\"]")
    end

    it "returns false for unsorted entries" do
      success, message = RenovateConfigAsdf::Linter.lint_default_json("spec/fixtures/default-invalid-unsorted.json")
      success.should eq(false)
      message.should contain("Examples are not sorted")
    end
  end
end
