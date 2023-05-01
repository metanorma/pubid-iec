module Pubid::Iec
  module Identifier
    class InternationalStandard < Base
      def_delegators 'Pubid::Iec::Identifier::InternationalStandard', :type

      def self.type
        { key: :is, title: "International Standard", short: "IS" }
      end
    end
  end
end
