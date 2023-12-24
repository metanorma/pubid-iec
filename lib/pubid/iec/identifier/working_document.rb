require "forwardable"

module Pubid::Iec
  module Identifier
    class WorkingDocument < Pubid::Core::Identifier::Base
      STAGES = %w[ACDV ACD ADTR ADTS AFDIS APUB BPUB CAN CDM CCDV CDISH CDVM
                  CFDIS CDPAS CDTR CDTS DTRM DTSM DECDISH DECFDIS DECPUB
                  DELPUB DEL NCDV NDTR NDTS NFDIS PCC PNW PPUB PRVC PRVDISH
                  PRVDPAS PRVDTR PRVDTS PRVD PRVN PWI RDISH RFDIS RPUB TCDV TDISH
                  TDTR TDTS TPUB WPUB AC CC CDV CD DA DV DC DISH DL DPAS DTR
                  DTS FDIS INF MTG NP QP Q RM RQ RR RVC RVDISH RVDTR RVDTS RVD
                  RVN RV R SBP].freeze

      extend Forwardable

      attr_accessor :technical_committee

      def initialize(publisher: "IEC", technical_committee: nil, stage: nil, **args)
        super(**args.merge(publisher: publisher))
        @stage = stage
        @technical_committee = technical_committee
      end

      def urn
        Renderer::WorkingDocumentUrn.new(renderer_data).render
      end

      def renderer_data
        to_h(deep: false)
      end

      class << self
        def get_parser_class
          WorkingDocumentParser
        end

        def get_renderer_class
          Renderer::WorkingDocument
        end
      end
    end
  end
end
