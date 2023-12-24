module Pubid::Iec
  module Identifier
    class OperationalDocument < Base
      def_delegators 'Pubid::Iec::Identifier::OperationalDocument', :type

      def self.type
        { key: :od, title: "Operational Document", short: "OD" }
      end

      def to_h(deep: false)
        super.merge(type: "OD")
      end
    end
  end
end
