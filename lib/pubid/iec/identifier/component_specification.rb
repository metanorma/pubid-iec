module Pubid::Iec
  module Identifier
    class ComponentSpecification < Base
      def_delegators 'Pubid::Iec::Identifier::ComponentSpecification', :type

      def self.type
        { key: :cs, title: "Component Specification", short: "CS" }
      end

      def to_h(deep: false)
        super.merge(type: "CS")
      end
    end
  end
end
