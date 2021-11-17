require_relative "spec_helper"

require_relative "../parser"

RSpec.describe "Parser" do
  let(:input) do
    [
      ["-3875450241286741606", "start", "2021-11-07 12:00:00 +0100", "a"],
      ["-3875450241286741606", "stop", "2021-11-07 13:01:01 +0100", "a"],
      ["-1464921669341722000", "start", "2021-11-07 13:00:00 +0100", "b"],
      ["-1464921669341722000", "stop", "2021-11-07 13:01:00 +0100", "b"]
    ]
  end

  let(:output) do
    [
      ["a", "1h 1m 1s"],
      ["b", "0h 1m 0s"]
    ]
  end

  it "works" do
    expect(Parser.new(input).parse).to eq(output)
  end
end

