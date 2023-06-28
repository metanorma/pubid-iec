module Pubid::Iec
  module Identifier
    class PubliclyAvailableSpecification < Base
      def_delegators 'Pubid::Iec::Identifier::PubliclyAvailableSpecification', :type

      TYPED_STAGES = {
        cdpas: {
          abbr: "CDPAS",
          name: "Draft circulated as DPAS",
          harmonized_stages: %w[50.20],
        },
        PRVDPAS: {
          abbr: "PRVDPAS",
          name: "Preparation of RVDPAS",
          harmonized_stages: %w[50.60],
        }
      }.freeze

      def self.type
        { key: :pas, title: "Publicly Available Specification", short: "PAS" }
      end

      def get_params
        super.merge(type: "PAS")
      end
    end
  end
end
