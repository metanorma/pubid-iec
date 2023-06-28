module Pubid::Iec
  module Identifier
    class TechnicalSpecification < Base
      TYPED_STAGES = {
        adts: {
          abbr: "ADTS",
          name: "Approved for DTS",
          harmonized_stages: %w[40.99],
        },
        cdts: {
          abbr: "CDTS",
          name: "Draft circulated as DTS",
          harmonized_stages: %w[50.20],
        },
        dtsm: {
          abbr: "DTSM",
          name: "Rejected DTS to be discussed at meeting",
          harmonized_stages: %w[50.92],
        },
        ndts: {
          abbr: "NDTS",
          name: "DTS rejected",
          harmonized_stages: %w[50.92],
        },
        prvdts: {
          abbr: "PRVDTS",
          name: "Preparation of RVDTS",
          harmonized_stages: %w[50.60],
        },
        tdts: {
          abbr: "TDTS",
          name: "Translation of DTS",
          harmonized_stages: %w[50.00],
        },
      }.freeze

      def_delegators 'Pubid::Iec::Identifier::TechnicalSpecification', :type

      def self.type
        { key: :ts, title: "Technical Specification", short: "TS" }
      end

      def get_params
        super.merge(type: "TS")
      end
    end
  end
end
