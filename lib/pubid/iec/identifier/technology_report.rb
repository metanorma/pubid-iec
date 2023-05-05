module Pubid::Iec
  module Identifier
    class TechnologyReport < Base
      def_delegators 'Pubid::Iec::Identifier::TechnologyReport', :type

      def self.type
        { key: :tec, title: "Technology Report", short: "Technology Report" }
      end

      def get_params
        super.merge(type: "Technology Report")
      end
    end
  end
end
