module Pubid::Iec
  module Identifier
    class TechnicalSpecification < Base
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
