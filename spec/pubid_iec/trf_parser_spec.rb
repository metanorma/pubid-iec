require "parslet/rig/rspec"

RSpec.describe Pubid::Iec::TrfParser do
  describe "#identifier" do
    subject { described_class.new.identifier }

    let(:iecee_pattern) { "60086-1&2A:2017"}
    let(:iecex_pattern) { "60079-15v1:2002" }

    context "when IECEE TRF" do
      context "with IECEE TRF scheme" do
        let(:identifier) { "IECEE TRF #{iecee_pattern}" }

        it { is_expected.to parse(identifier, trace: true) }
      end

      context "with IECEx TRF scheme" do
        let(:identifier) { "IECEE TRF #{iecex_pattern}" }

        it { is_expected.not_to parse(identifier, trace: true) }
      end
    end

    context "when IECEx TRF" do
      context "with IECEx TRF scheme" do
        let(:identifier) { "IECEx TRF #{iecex_pattern}" }

        it { is_expected.to parse(identifier, trace: true) }
      end

      context "with IECEE TRF scheme" do
        let(:identifier) { "IECEx TRF #{iecee_pattern}" }

        it { is_expected.not_to parse(identifier, trace: true) }
      end

      context "IECEx TRF 60079-0v7c_ds:2021" do
        let(:identifier) { "IECEx TRF 60079-0v7c_ds:2021" }

        it { is_expected.to parse(identifier, trace: true) }
      end
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

    context "parses identifiers from iecee-trf-pubid.txt" do
      let(:examples_file) { "iecee-trf-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iecex-trf-pubid.txt" do
      let(:examples_file) { "iecex-trf-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end
  end
end
