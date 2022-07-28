require "./spec_helper"

describe RenovateConfigAsdf::ReleaseManager do
  describe ".version?" do
    it "returns true when given a numbers delimited format like a simple semantic versioning" do
      RenovateConfigAsdf::ReleaseManager.version?("0.4.2").should eq(true)
    end

    it "returns false when given string contains non numbers" do
      RenovateConfigAsdf::ReleaseManager.version?("0.4.2.pre").should eq(false)
      RenovateConfigAsdf::ReleaseManager.version?("0.4.x").should eq(false)
    end
  end

  describe ".release" do
    it "raises ArgumentError when given an incorrect version" do
      expect_raises(ArgumentError) do
        RenovateConfigAsdf::ReleaseManager.release("0.4.x")
      end
    end
  end
end
