module Pubid::Iec
  module Identifier
    class Guide < Base
      def_delegators 'Pubid::Iec::Identifier::Guide', :type

      TYPED_STAGES = {
        dguide: {
          abbr: "DGuide",
          name: "Draft Guide",
          harmonized_stages: %w[40.00 40.20 40.60 40.92 40.98 40.99],
        },
        fdguide: {
          abbr: "FDGuide",
          name: "Final Draft Guide",
          harmonized_stages: %w[50.00 50.20 50.60 50.92 50.98 50.99],
        }
      }.freeze

      def self.type
        { key: :guide, title: "Guide", short: %w[Guide GUIDE] }
      end

      def to_h(deep: false)
        super.merge(type: "Guide")
      end
    end
  end
end
