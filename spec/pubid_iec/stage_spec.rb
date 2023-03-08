RSpec.describe Pubid::Iec::Stage do
  it "returns long title for stage" do
    expect(described_class.new(:ACDV).to_s(:urn)).to eq("30.99")
  end
end
