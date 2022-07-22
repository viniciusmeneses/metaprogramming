require_relative "context"

module RSpec
  def self.describe(_sut, &)
    Context.new(&).call
  end
end

RSpec.describe "Class" do
  it "should do something" do
    expect(2).to eq(2)
  end

  context "method" do
    it "should do something" do
      expect(4).to eq(4)
    end
  end
end
