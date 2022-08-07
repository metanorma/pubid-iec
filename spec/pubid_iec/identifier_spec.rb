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

  shared_examples "converts pubid to urn" do
    it "converts pubid to urn" do
      expect(subject.urn.to_s).to eq(urn)
    end
  end

  context "IEC 60050-351:2013/AMD1:2016" do
    let(:pubid) { "IEC 60050-351:2013/AMD1:2016" }
    let(:urn) { "urn:iec:std:iec:60050:-351:2013:amd:2016:v1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IEC 61010-2-201:2017 RLV" do
    let(:pubid) { "IEC 61010-2-201:2017 RLV" }
    let(:urn) { "urn:iec:std:iec:61010:-2-201:2017:rlv" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IEC 61666:2010+AMD1:2021 CSV" do
    let(:pubid) { "IEC 61666:2010+AMD1:2021 CSV" }
    let(:urn) { "urn:iec:std:iec:61666:2010:csv:amd:2021:v1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IEC 62439-1:2010+AMD1:2012+AMD2:2016 CSV" do
    let(:pubid) { "IEC 62439-1:2010+AMD1:2012+AMD2:2016 CSV" }
    let(:urn) { "urn:iec:std:iec:62439:-1:2010:csv:amd:2016:v2:amd:2012:v1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IEC 60050-102:2007/AMD1:2017 ED1" do
    let(:pubid) { "IEC 60050-102:2007/AMD1:2017 ED1" }
    let(:urn) { "urn:iec:std:iec:60050:-102:2007:ed-1:amd:2017:v1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IEC 60050-111/AMD1/FRAG1 ED2" do
    let(:pubid) { "IEC 60050-111/AMD1/FRAG1 ED2" }
    let(:urn) { "urn:iec:std:iec:60050:-111:ed-2:amd:1:v1:frag:1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IEC CA 01:2020 CSV" do
    let(:pubid) { "IEC CA 01:2020 CSV" }
    let(:urn) { "urn:iec:std:iec:ca:01:2020:csv" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEE TRF 10079-1A:2020" do
    let(:pubid) { "IECEE TRF 10079-1A:2020" }
    let(:urn) { "urn:iec:std:iecee:trf:10079:-1:2020:vA" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEx TRF 16852v2A:2017" do
    let(:original) { "IECEx TRF 16852v2A:2017" }
    let(:pubid) { "IECEx TRF 16852v2A:2017" }
    let(:urn) { "urn:iec:std:iecex:trf:16852:2017:v2A" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEx TRF 60079-0v7B_DS:2018" do
    let(:pubid) { "IECEx TRF 60079-0v7B_DS:2018" }
    let(:urn) { "urn:iec:std:iecex:trf:60079:-0:2018:v7B" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
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
    let(:pubid) { "IECEE TRF 60335-2-10&54B:2017" }
    let(:urn) { "urn:iec:std:iecee:trf:60335:-2-10,54:2017:vB" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEE TRF 60086-1&2A:2017" do
    let(:original) { "IECEE TRF 60086-1&2A:2017" }
    let(:pubid) { "IECEE TRF 60086-1&2A:2017" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60335-2-6,9,25B:2020" do
    let(:pubid) { "IECEE TRF 60335-2-6&9&25B:2020" }
    let(:urn) { "urn:iec:std:iecee:trf:60335:-2-6,9,25:2020:vB" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEE TRF CISPR 15K:2019" do
    let(:pubid) { "IECEE TRF CISPR 15K:2019" }
    let(:urn) { "urn:iec:std:iecee:trf:cispr:15K:2019" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEE TRF cispr 15N:2022" do
    let(:original) { "IECEE TRF cispr 15N:2022" }
    let(:pubid) { "IECEE TRF CISPR 15N:2022" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60127-2-iBI:2011" do
    let(:original) { "IECEE TRF 60127-2-iBI:2011" }
    let(:pubid) { "IECEE TRF 60127-2B_I:2011" }
    let(:urn) { "urn:iec:std:iecee:trf:60127:-2:2011:vB_I" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "IECEE TRF 60601-1-2J_EMC:2021" do
    let(:pubid) { "IECEE TRF 60601-1-2J_EMC:2021" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 61215E_SE:2021" do
    let(:pubid) { "IECEE TRF 61215E_SE:2021" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECQ 080000-EN:2017" do
    let(:pubid) { "IECQ 080000-EN:2017" }

    it_behaves_like "converts pubid to pubid"
  end

  context "IECEE TRF 60335-2-35C:1997" do
    let(:pubid) { "IECEE TRF 60335-2-35C:1997" }

    it_behaves_like "converts pubid to pubid"
  end

  context "PWI 100-44 ED1" do
    let(:original) { "PWI 100-44 ED1" }
    let(:pubid) { "IEC PWI 100-44 ED1"}
    let(:urn) { "urn:iec:std:iec:100:-44:stage-00.00:ed-1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
  end

  context "PWI SRD SyCCOMM-1 ED1" do
    let(:original) { "PWI SRD SyCCOMM-1 ED1" }
    let(:pubid) { "IEC SRD PWI SyCCOMM-1 ED1" }
    let(:urn) { "urn:iec:std:iec:srd:syccomm:-1:stage-00.00:ed-1" }

    it_behaves_like "converts pubid to pubid"
    it_behaves_like "converts pubid to urn"
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
