require "parslet/rig/rspec"

RSpec.describe Pubid::Iec::Parser do
  subject { described_class.new }

  describe "#identifier" do
    let(:identifier) { "IEC 60050-351:2013" }

    it "parses iso identifier" do
      expect(subject.identifier).to parse(identifier, trace: true)
    end

    it "parses identifier with edition" do
      expect(subject.identifier).to parse("IEC 61691-6 Edition 1.0 2009-12", trace: true)
    end
  end

  describe "parse identifiers from examples files" do
    shared_examples "parse identifiers from file" do
      it "parse identifiers from file" do
        f = open("spec/fixtures/#{examples_file}")
        f.readlines.each do |pub_id|
          next if pub_id.match?("^#")
          expect(subject).to parse(pub_id.split("#").first.strip.chomp, trace: true)
        end
      end
    end

    context "parses identifiers from iec-pubid.txt" do
      let(:examples_file) { "iec-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from working-programmes.txt" do
      let(:examples_file) { "working-programmes.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from tc1-pubid.txt" do
      let(:examples_file) { "tc1-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from vap-pubid.txt" do
      let(:examples_file) { "vap-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from csv-pubid.txt" do
      let(:examples_file) { "csv-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from ish-pubid.txt" do
      let(:examples_file) { "ish-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end
  end
end
