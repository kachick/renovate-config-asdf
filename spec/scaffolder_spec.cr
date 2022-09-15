require "./spec_helper"

describe RenovateConfigAsdf::Scaffolder do
  describe ".scaffold" do
    it "generates JSON from given plugin name" do
      scaffold = RenovateConfigAsdf::Scaffolder.scaffold("foobar")
      scaffold.should contain("depNameTemplate\": \"owner/foobar")
    end
  end
end
