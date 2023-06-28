module Pubid::Iec
  module Identifier
    class TechnicalReport < Base
      def_delegators 'Pubid::Iec::Identifier::TechnicalReport', :type

      TYPED_STAGES = {
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

      def self.type
        { key: :tr, title: "Technical Report", short: "TR" }
      end

      def get_params
        super.merge(type: "TR")
      end
    end
  end
end
