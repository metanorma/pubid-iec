module Pubid::Iec
  RSpec.describe Identifier do
    describe "creating new identifier" do
      subject { described_class.create(**{ number: number }.merge(params)) }
      let(:number) { 123 }
      let(:params) { {} }

      it "renders default publisher" do
        expect(subject.to_s).to eq("IEC #{number}")
      end

      context "when have document type" do
        let(:params) { { type: :tr } }

        it "renders document type" do
          expect(subject.to_s).to eq("IEC TR #{number}")
        end
      end

      context "when have language" do
        let(:params) { { language: "en" } }

        it "renders language" do
          expect(subject.to_s).to eq("IEC #{number}(en)")
        end

        context "several languages" do
          let(:params) { { language: %w[en fr] } }

          it "renders language" do
            expect(subject.to_s).to eq("IEC #{number}(en-fr)")
            expect(subject.urn).to eq("urn:iec:std:iec:#{number}:en-fr")
          end
        end
      end

      context "when the same stage applied to different types" do
        context "TR" do
          let(:params) { { type: "TR", stage: "40.99" } }

          it "renders stage" do
            expect(subject.to_s).to eq("IEC ADTR #{number}")
          end
        end
      end

      context "TS" do
        let(:params) { { type: "TS", stage: "40.99" } }

        it "renders stage" do
          expect(subject.to_s).to eq("IEC ADTS #{number}")
        end
      end

    end
  end
end
