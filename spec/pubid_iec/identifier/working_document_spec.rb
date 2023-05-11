module Pubid::Iec
  RSpec.describe WorkingDocument do
    subject { described_class.parse(original || pubid) }
    let(:original) { nil }

    context "100/3590/CDV" do
      let(:pubid) { "100/3590/CDV" }
      let(:urn) { "urn:iec:working-document:100:3590:stage-cdv" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to urn"
    end

    context "82/2031/CC" do
      let(:pubid) { "82/2031/CC" }
      let(:urn) { "urn:iec:working-document:82:2031:stage-cc" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to urn"
    end

    context "SyCSmartEnergy/158/Q" do
      let(:pubid) { "SyCSmartEnergy/158/Q" }
      let(:urn) { "urn:iec:working-document:sycsmartenergy:158:stage-q" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to urn"
    end

    context "SyCLVDC/112A/RM" do
      let(:pubid) { "SyCLVDC/112A/RM" }
      let(:urn) { "urn:iec:working-document:syclvdc:112a:stage-rm" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to urn"
    end

    context "86B/4488(F)/CDV" do
      let(:pubid) { "86B/4488(F)/CDV" }
      let(:urn) { "urn:iec:working-document:86b:4488(f):stage-cdv" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to urn"
    end

    context "86B/4511A/CC" do
      let(:pubid) { "86B/4511A/CC" }

      it_behaves_like "converts pubid to pubid"
    end

    context "CISPR/1474/RQ" do
      let(:pubid) { "CISPR/1474/RQ" }

      it_behaves_like "converts pubid to pubid"
    end

    context "CIS/D/468A/CC" do
      let(:pubid) { "CIS/D/468A/CC" }

      let(:urn) { "urn:iec:working-document:cis-d:468a:stage-cc" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to urn"
    end

    context "JTC1-SC41/250/RVC" do
      let(:pubid) { "JTC1-SC41/250/RVC" }

      it_behaves_like "converts pubid to pubid"
    end

    context "SEG11/17/INF" do
      let(:pubid) { "SEG11/17/INF" }

      it_behaves_like "converts pubid to pubid"
    end

    context "SMB/7883A/RV" do
      let(:pubid) { "SMB/7883A/RV" }

      it_behaves_like "converts pubid to pubid"
    end

    context "ACSEC/86/DA" do
      let(:pubid) { "ACSEC/86/DA" }

      it_behaves_like "converts pubid to pubid"
    end

    context "CIS/F/814/INF" do
      let(:pubid) { "CIS/F/814/INF" }

      it_behaves_like "converts pubid to pubid"
    end

    context "100/3644" do
      let(:pubid) { "100/3644" }
      let(:urn) { "urn:iec:working-document:100:3644" }


      it_behaves_like "converts pubid to urn"
      it_behaves_like "converts pubid to pubid"
    end

    describe "parse identifiers from examples files" do
      context "parses IEC identifiers from working-documents.txt" do
        let(:examples_file) { "working-documents.txt" }

        it_behaves_like "parse identifiers from file"
      end

      context "parses IEC identifiers from wd-special-groups.txt" do
        let(:examples_file) { "wd-special-groups.txt" }

        it_behaves_like "parse identifiers from file"
      end
    end
  end
end
