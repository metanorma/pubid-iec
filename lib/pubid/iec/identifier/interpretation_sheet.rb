module Pubid::Iec
  module Identifier
    class InterpretationSheet < Base
      def_delegators 'Pubid::Iec::Identifier::InterpretationSheet', :type

      TYPED_STAGES = {
        cdish: {
          abbr: "CDISH",
          name: "Draft circulated as DISH",
          harmonized_stages: %w[30.00 30.20 30.60 30.92 30.98 30.99],
        },
        dish: {
          abbr: "DISH",
          name: "Draft Interpretation Sheet",
          harmonized_stages: %w[50.00 50.20 50.60 50.92 50.98 50.99],
        }
      }.freeze

      PROJECT_STAGES = {
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

      def initialize(base: nil, **opts)
        super(**opts)
        @base = base
      end

      def self.type
        { key: :ish, title: "Interpretation Sheet", short: "ISH" }
      end

      def self.get_renderer_class
        Renderer::InterpretationSheet
      end
    end
  end
end
