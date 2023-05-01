module Pubid::Iec
  module Identifier
    class TechnicalReport < Base
      def_delegators 'Pubid::Iec::Identifier::TechnicalReport', :type

      def self.type
        { key: :tr, title: "Technical Report", short: "TR" }
      end

      def get_params
        super.merge(type: "TR")
      end
    end
  end
end
