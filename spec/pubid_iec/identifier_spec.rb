RSpec.describe Pubid::Iec::Identifier do
  subject { described_class.parse(original || pubid) }
  let(:original) { nil }

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

    context "parses identifiers from tc1-pubid.txt" do
      let(:examples_file) { "tc1-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end

    context "parses identifiers from iecq-pubid.txt" do
      let(:examples_file) { "iecq-pubid.txt" }

      it_behaves_like "parse identifiers from file"
    end
  end

  shared_examples "converts pubid to pubid" do
    it "converts pubid to pubid" do
      expect(subject.to_s).to eq(pubid)
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

  context "IEC 60050-102:2007/AMD1:2017 ED1" do
    let(:original) { "IEC 60050-102:2007/AMD1:2017 ED1" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IEC 60050-111/AMD1/FRAG1 ED2" do
    let(:original) { "IEC 60050-111/AMD1/FRAG1 ED2" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IEC CA 01:2020 CSV" do
    let(:original) { "IEC CA 01:2020 CSV" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IECEE TRF 10079-1A:2020" do
    let(:original) { "IECEE TRF 10079-1A:2020" }

    it { expect(subject.to_s).to eq(original) }
  end

  context "IECEx TRF 16852v2A:2017" do
    let(:original) { "IECEx TRF 16852v2A:2017" }
    let(:pubid) { "IECEx TRF 16852v2A:2017" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEx TRF 60079-0v7B_DS:2018" do
    let(:pubid) { "IECEx TRF 60079-0v7B_DS:2018" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEx TRF 60079-0v7c_ds:2021" do
    let(:pubid) { "IECEx TRF 60079-0v7c_ds:2021" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEx TRF 60079-11v6A2:2012" do
    let(:pubid) { "IECEx TRF 60079-11v6A2:2012" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60335-2-10,54B:2017" do
    let(:pubid) { "IECEE TRF 60335-2-10,54B:2017" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60086-1&2A:2017" do
    let(:original) { "IECEE TRF 60086-1&2A:2017" }
    let(:pubid) { "IECEE TRF 60086-1,2A:2017" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60335-2-6,9,25B:2020" do
    let(:pubid) { "IECEE TRF 60335-2-6,9,25B:2020" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF CISPR 15K:2019" do
    let(:pubid) { "IECEE TRF CISPR 15K:2019" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF cispr 15N:2022" do
    let(:original) { "IECEE TRF cispr 15N:2022" }
    let(:pubid) { "IECEE TRF CISPR 15N:2022" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60127-2-iBI:2011" do
    let(:original) { "IECEE TRF 60127-2-iBI:2011" }
    let(:pubid) { "IECEE TRF 60127-2B_I:2011" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60601-1-2J_EMC:2021" do
    let(:pubid) { "IECEE TRF 60601-1-2J_EMC:2021" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 61215E_SE:2021" do
    let(:pubid) { "IECEE TRF 61215E_SE:2021" }

    it_behaves_like "converts pubid to pubid"
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
