RSpec.describe Pubid::Iec::Identifier do
  subject { described_class.parse(original) }

  describe "parse identifiers from examples files" do
    shared_examples "parse identifiers from file" do
      it "parse identifiers from file" do
        f = open("spec/fixtures/#{examples_file}")
        f.readlines.each do |pub_id|
          next if pub_id.match?("^#")

          pub_id = pub_id.split("#").first.strip.chomp
          expect do
            described_class.parse(pub_id)
          rescue Exception => failure
            raise Pubid::Core::Errors::ParseError,
                  "couldn't parse #{pub_id}\n#{failure.message}"
          end.not_to raise_error

          expect(described_class.parse(pub_id).to_s).to eq(pub_id)
        end
      end
    end

    context "parses identifiers from pubid-parsed.txt" do
      let(:examples_file) { "iec-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from tr-pubid.txt" do
      let(:examples_file) { "tr-pubid.txt" }
      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from ts-pubid.txt" do
      let(:examples_file) { "ts-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from od-pubid.txt" do
      let(:examples_file) { "od-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end
  end

  context "IEC 60050-351:2013/AMD1:2016" do
    let(:original) { "IEC 60050-351:2013/AMD1:2016" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IEC 61010-2-201:2017 RLV" do
    let(:original) { "IEC 61010-2-201:2017 RLV" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IEC 61666:2010+AMD1:2021 CSV" do
    let(:original) { "IEC 61666:2010+AMD1:2021 CSV" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IEC 62439-1:2010+AMD1:2012+AMD2:2016 CSV" do
    let(:original) { "IEC 62439-1:2010+AMD1:2012+AMD2:2016 CSV" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "database identifier" do
    context "when have DB" do
      let(:original) { "IEC 60061:2022 DB" }

      it { expect(subject.database).to eq(true) }
    end

    context "when no DB" do
      let(:original) { "IEC 60061:2022" }

      it { expect(subject.database).to eq(false) }
    end
  end
end
