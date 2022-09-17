require "./spec_helper"

describe RenovateConfigAsdf::Cli do
  describe "#run" do
    it "outputs usage" do
      io = IO::Memory.new
      cli = RenovateConfigAsdf::Cli.new(io)
      cli.run(["--help"])
      io.to_s.should contain("Usage: [arguments]")
    end
  end
end
