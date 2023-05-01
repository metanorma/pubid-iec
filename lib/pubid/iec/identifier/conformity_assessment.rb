module Pubid::Iec
  module Identifier
    class ConformityAssessment < Base
      def_delegators 'Pubid::Iec::Identifier::ConformityAssessment', :type

      def self.type
        { key: :ca, title: "Conformity Assessment", short: "CA" }
      end

      def get_params
        super.merge(type: "CA")
      end
    end
  end
end
