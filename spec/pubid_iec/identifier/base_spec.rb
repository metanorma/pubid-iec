module Pubid::Iec
  RSpec.describe Base do
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

            expect(described_class.parse(pub_id).to_s.upcase).to eq(pub_id.upcase)
          end
        end
      end

      context "parses IEC identifiers from iec-pubid.txt" do
        let(:examples_file) { "iec-pubid.txt" }

        it_behaves_like "parse identifiers from file"
      end

      context "parses IEC TR identifiers from tr-pubid.txt" do
        let(:examples_file) { "tr-pubid.txt" }
        it_behaves_like "parse identifiers from file"
      end

      context "parses IEC TS identifiers from ts-pubid.txt" do
        let(:examples_file) { "ts-pubid.txt" }

        it_behaves_like "parse identifiers from file"
      end

      context "parses IECQ identifiers from iecq-pubid.txt" do
        let(:examples_file) { "iecq-pubid.txt" }

        it_behaves_like "parse identifiers from file"
      end

      context "parses ISO/IEC identifiers from iso-iec-pubid.txt" do
        let(:examples_file) { "iso-iec-pubid.txt" }

        it_behaves_like "parse identifiers from file"
      end
    end

    shared_examples "converts pubid to pubid" do
      it "converts pubid to pubid" do
        expect(subject.to_s).to eq(pubid)
      end
    end

    shared_examples "converts pubid to pubid with edition month-date" do
      it "converts pubid to pubid with edition month-date" do
        expect(subject.to_s(with_edition_month_date: true)).to eq(pubid)
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

      it { expect(subject).to be_a(Identifier::InternationalStandard) }
    end

    context "IEC TR 60083:2015" do
      let(:pubid) { "IEC TR 60083:2015" }

      it_behaves_like "converts pubid to pubid"

      it { expect(subject).to be_a(Identifier::TechnicalReport) }
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


    context "IECQ 080000-EN:2017" do
      let(:pubid) { "IECQ 080000-EN:2017" }

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

    context "ISO/IEC VIM:1993" do
      let(:pubid) { "ISO/IEC VIM:1993" }

      it_behaves_like "converts pubid to pubid"
    end

    context "ISO/IEC GUIDE 2:2004" do
      let(:original) { "ISO/IEC GUIDE 2:2004" }
      let(:pubid) { "ISO/IEC Guide 2:2004" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 61834-10:2001/COR1:2001" do
      let(:pubid) { "IEC 61834-10:2001/COR1:2001" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 62133-2:2017/AMD1:2021/COR1:2021" do
      let(:pubid) { "IEC 62133-2:2017/AMD1:2021/COR1:2021" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IECQ OD 3405:2017" do
      let(:pubid) { "IECQ OD 3405:2017" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC TS 60034-16-3:1996" do
      let(:pubid) { "IEC TS 60034-16-3:1996" }

      it_behaves_like "converts pubid to pubid"
    end

    context "ISO/IEC 11801:1995+AMD1:1999+AMD2:1999 CSV" do
      let(:pubid) { "ISO/IEC 11801:1995+AMD1:1999+AMD2:1999 CSV" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 60335-1:2010/A1:2013" do
      let(:original) { "IEC 60335-1:2010/A1:2013" }
      let(:pubid) { "IEC 60335-1:2010/AMD1:2013" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC 60335-1:2010/A1:2013 + COR:2014" do
      let(:original) { "IEC 60335-1:2010/A1:2013 + COR:2014" }
      let(:pubid) { "IEC 60335-1:2010/AMD1:2013/COR1:2014" }

      it_behaves_like "converts pubid to pubid"
    end

    context "White Paper" do
      context "IEC White Paper AI:2018" do
        let(:pubid) { "IEC White Paper AI:2018" }

        it_behaves_like "converts pubid to pubid"
      end

      context "IEC White Paper RE-EES:2012" do
        let(:pubid) { "IEC White Paper RE-EES:2012" }

        it_behaves_like "converts pubid to pubid"
      end

      context "IEC White Paper Asset Management:2015" do
        let(:pubid) { "IEC White Paper Asset Management:2015" }

        it_behaves_like "converts pubid to pubid"
      end

      context "IEC White Paper IoT:WSN:2014" do
        let(:pubid) { "IEC White Paper IoT:WSN:2014" }

        it_behaves_like "converts pubid to pubid"
      end

      context "IEC White Paper Safety in the future:2020" do
        let(:pubid) { "IEC White Paper Safety in the future:2020" }

        it_behaves_like "converts pubid to pubid"
      end
    end

    context "Technology Report" do
      context "IEC Technology Report LVDC:2017" do
        let(:pubid) { "IEC Technology Report LVDC:2017" }

        it_behaves_like "converts pubid to pubid"

        it { expect(subject).to be_a(Identifier::TechnologyReport) }
      end

      context "IEC Technology Report City information modelling:2021" do
        let(:pubid) { "IEC Technology Report City information modelling:2021" }

        it_behaves_like "converts pubid to pubid"

        it { expect(subject).to be_a(Identifier::TechnologyReport) }
      end
    end

    context "IEC 60794-1-23:2019-10" do
      let(:original) { "IEC 60794-1-23:2019-10" }
      let(:pubid) { "IEC 60794-1-23:2019" }

      it_behaves_like "converts pubid to pubid"

      context "with edition month" do
        let(:pubid) { "IEC 60794-1-23:2019-10" }
        it_behaves_like "converts pubid to pubid with edition month-date"
      end
    end

    context "IEC 60500-113:2022-03-18" do
      let(:pubid) { "IEC 60500-113:2022-03-18" }

      it_behaves_like "converts pubid to pubid with edition month-date"
    end

    context "IEC/ASTM 62885-6:2018" do
      let(:pubid) { "IEC/ASTM 62885-6:2018" }

      it_behaves_like "converts pubid to pubid"
    end

    context "IEC Trend Report Digital healthcare:2021" do
      let(:pubid) { "IEC Trend Report Digital healthcare:2021" }

      it_behaves_like "converts pubid to pubid"

      it { expect(subject).to be_a(Identifier::SocietalTechnologyTrendReport) }
    end

    context "IEC 60794-1-23:2019-10(en)" do
      let(:pubid) { "IEC 60794-1-23:2019-10(en)" }

      it_behaves_like "converts pubid to pubid with edition month-date"
    end

    context "IEC 60794-1-23:2019-10(en-fr)" do
      let(:pubid) { "IEC 60794-1-23:2019-10(en-fr)" }

      it_behaves_like "converts pubid to pubid with edition month-date"
    end

    context "database identifier" do
      context "with DB and with year" do
        let(:original) { "IEC 60061:2022 DB" }

        it { expect(subject.database).to eq(true) }
      end

      context "with DB but no year (CDD)" do
        let(:original) { "IEC 61360-4 DB" }

        it { expect(subject.database).to eq(true) }
      end

      context "with no DB" do
        let(:original) { "IEC 60061:2022" }

        it { expect(subject.database).to eq(false) }
      end
    end

    describe "creating new identifier" do
      subject { described_class.new(**{ number: number }.merge(params)) }
      let(:number) { 123 }

      context "when have stage" do
        let(:params) { { stage: "CD" } }

        it "renders correct PubID" do
          expect(subject.to_s).to eq("IEC CD #{number}")
        end

        it "renders correct URN" do
          expect(subject.urn).to eq("urn:iec:std:iec:123:stage-30.20")
        end
      end
    end
  end
end
