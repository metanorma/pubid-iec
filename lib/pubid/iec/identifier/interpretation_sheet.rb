module Pubid::Iec
  module Identifier
    class InterpretationSheet < Base
      def_delegators 'Pubid::Iec::Identifier::InterpretationSheet', :type

      TYPED_STAGES = {
        cdish: {
          abbr: "CDISH",
          name: "Draft circulated as DISH",
          harmonized_stages: %w[50.20],
        },
        decdish: {
          abbr: "DECDISH",
          name: "DISH at editing check",
          harmonized_stages: %w[50.00],
        },
        prvdish: {
          abbr: "PRVDISH",
          name: "Preparation of RVDISH",
          harmonized_stages: %w[50.60],
        },
        rdish: {
          abbr: "RDISH",
          name: "DISH received and registered",
          harmonized_stages: %w[50.00],
        },
        tdish: {
          abbr: "TDISH",
          name: "Translation of DISH",
          harmonized_stages: %w[50.00],
        },
      }.freeze

      def self.type
        { key: :ish, title: "InterpretationSheet", short: "ISH" }
      end

      def get_params
        super.merge(type: "ISH")
      end
    end
  end
end
