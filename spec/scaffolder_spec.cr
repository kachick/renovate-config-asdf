require "./spec_helper"

describe RenovateConfigAsdf::Scaffolder do
  describe ".scaffold" do
    it "generates JSON from given plugin name" do
      scaffold = RenovateConfigAsdf::Scaffolder.scaffold("foobar")
      scaffold.should contain("depNameTemplate\": \"owner/foobar")
    end
  end

  describe ".insert_entry" do
    it "returns new array that inserts given entry into correct position" do
      entires = %w(bun crystal ruby)
      RenovateConfigAsdf::Scaffolder.insert_entry(entires, "deno").should eq(%w(bun crystal deno ruby))
    end

    it "does not touch base entries" do
      entires = %w(bun crystal ruby)
      RenovateConfigAsdf::Scaffolder.insert_entry(entires, "deno")
      entires.should eq(%w(bun crystal ruby))
    end

    it "works even if given entry will be first position" do
      entires = %w(crystal ruby)
      RenovateConfigAsdf::Scaffolder.insert_entry(entires, "bun").should eq(%w(bun crystal ruby))
    end

    it "works even if given entry will be last position" do
      entires = %w(bun crystal)
      RenovateConfigAsdf::Scaffolder.insert_entry(entires, "ruby").should eq(%w(bun crystal ruby))
    end
  end
end
