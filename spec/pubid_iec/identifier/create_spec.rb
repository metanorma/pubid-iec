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

        it "returns typed stage" do
          expect(subject.typed_stage_abbrev).to eq("TR")
        end

        it "returns typed stage name" do
          expect(subject.typed_stage_name).to eq("Technical Report")
        end

        context "ISH type" do
          let(:params) { { type: :ish, base: Identifier.create(number: number)} }

          it "renders ISH document type" do
            expect(subject.to_s).to eq("IEC #{number}/ISH#{number}")
          end

          it "returns typed stage" do
            expect(subject.typed_stage_abbrev).to eq("ISH")
          end

          it "returns typed stage name" do
            expect(subject.typed_stage_name).to eq("Interpretation Sheet")
          end
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
          let(:params) { { type: "TR", stage: stage } }
          let(:stage) { "50.60" }

          it "renders stage" do
            expect(subject.to_s).to eq("IEC DTR #{number}")
          end
        end
      end

      context "TS" do
        let(:params) { { type: "TS", stage: stage } }
        let(:stage) { "50.60" }

        it "renders stage" do
          expect(subject.to_s).to eq("IEC DTS #{number}")
        end

        context "when project stage" do
          let(:stage) { "PRVDTS" }

          it "renders closest stage" do
            expect(subject.to_s).to eq("IEC DTS #{number}")
          end
        end

        context "when project stage" do
          context "typed project stage" do
            let(:stage) { "ADTS" }

            it "renders closest stage" do
              expect(subject.to_s).to eq("IEC TS CDV #{number}")
            end
          end

          context "untyped project stage" do
            let(:stage) { "ACD" }

            it "renders closest stage" do
              expect(subject.to_s).to eq("IEC TS WD #{number}")
            end

            context "when indentifier's stage is not available" do
              let(:stage) { "DECPUB" }

              it "renders without stage" do
                expect(subject.to_s).to eq("IEC TS #{number}")
                expect(subject.urn).to eq("urn:iec:std:iec:ts:#{number}:stage-60.00")
              end
            end
          end

        end

        context "when normal stage" do
          let(:stage) { "CD" }

          it "renders stage" do
            expect(subject.to_s).to eq("IEC TS CD #{number}")
          end

          context "NP stage" do
            let(:stage) { "PNW" }

            it "renders stage" do
              expect(subject.to_s).to eq("IEC TS PNW #{number}")
            end
          end

          context "PWI stage" do
            let(:stage) { "PWI" }

            it "renders stage" do
              expect(subject.to_s).to eq("IEC TS PWI #{number}")
            end
          end
        end
      end

      context "ISH" do
        let(:params) { { type: "ISH", stage: stage, base: Identifier.create(number: number) } }
        let(:stage) { "50.60" }

        it "renders stage" do
          expect(subject.to_s).to eq("IEC #{number}/DISH#{number}")
        end

        it "returns typed stage" do
          expect(subject.typed_stage_abbrev).to eq("DISH")
        end
      end

      context "CD" do
        let(:params) { { stage: "CD" } }

        it "renders stage" do
          expect(subject.to_s).to eq("IEC CD #{number}")
        end

        it "returns typed stage" do
          expect(subject.typed_stage_abbrev).to eq("CD IS")
        end

        it "returns typed stage name" do
          expect(subject.typed_stage_name).to eq("Draft circulated as CD International Standard")
        end
      end

      context "CDV" do
        let(:params) { { stage: "CDV" } }

        it "returns typed stage name" do
          expect(subject.typed_stage_name).to eq("Committee Draft for Vote International Standard")
        end
      end
    end
  end
end
