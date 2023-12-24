module Pubid::Iec
  module Identifier
    class TechnicalReport < Base
      def_delegators 'Pubid::Iec::Identifier::TechnicalReport', :type

      PROJECT_STAGES = {
        adtr: {
          abbr: "ADTR",
          name: "Approved for DTR",
          harmonized_stages: %w[40.99],
        },
        cdtr: {
          abbr: "CDTR",
          name: "Draft circulated as DTR",
          harmonized_stages: %w[50.20],
        },
        dtrm: {
          abbr: "DTRM",
          name: "Rejected DTR to be discussed at meeting",
          harmonized_stages: %w[50.92],
        },
        ndtr: {
          abbr: "NDTR",
          name: "DTR rejected",
          harmonized_stages: %w[50.92],
        },
        prvdtr: {
          abbr: "PRVDTR",
          name: "Preparation of RVDTR",
          harmonized_stages: %w[50.60]
        },
        tdtr: {
          abbr: "TDTR",
          name: "Translation of DTR",
          harmonized_stages: %w[50.00]
        }
      }.freeze

      TYPED_STAGES = {
        dtr: {
          abbr: "DTR",
          name: "Draft Technical Report",
          harmonized_stages: %w[50.00 50.20 50.60 50.92 50.98 50.99],
        }
      }.freeze

      def self.type
        { key: :tr, title: "Technical Report", short: "TR" }
      end

      def to_h(deep: false)
        super.merge(type: "TR")
      end
    end
  end
end
