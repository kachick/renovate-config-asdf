require "./spec_helper"

private def defined_plugins
  %w[
    crystal
    deno
    ruby
    rust
  ]
end

describe RenovateConfigAsdf::Linter do
  describe ".lint_example" do
    it "returns true for same entries" do
      success, _message = RenovateConfigAsdf::Linter.lint_example("spec/fixtures/.tool-versions-valid", defined_plugins)
      success.should eq(true)
    end

    it "returns false for duplicated entries" do
      success, message = RenovateConfigAsdf::Linter.lint_example("spec/fixtures/.tool-versions-invalid-duplicated", defined_plugins)
      success.should eq(false)
      message.should contain("Examples are duplicated")
    end

    it "returns false for unsorted entries" do
      success, message = RenovateConfigAsdf::Linter.lint_example("spec/fixtures/.tool-versions-invalid-unsorted", defined_plugins)
      success.should eq(false)
      message.should contain("Examples are not sorted")
    end
  end

  describe ".lint_default_json" do
    it "returns true for same entries" do
      success, _message = RenovateConfigAsdf::Linter.lint_default_json("spec/fixtures/default-valid.json", defined_plugins)
      success.should eq(true)
    end

    it "returns false for missing entries" do
      success, message = RenovateConfigAsdf::Linter.lint_default_json("spec/fixtures/default-invalid-missing.json", defined_plugins)
      success.should eq(false)
      message.should contain("Some plugins are not linked: [\"crystal\", \"ruby\"]")
    end
  end
end
