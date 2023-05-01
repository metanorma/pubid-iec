module Pubid::Iec
  module Identifier
    class PubliclyAvailableSpecification < Base
      def_delegators 'Pubid::Iec::Identifier::PubliclyAvailableSpecification', :type

      def self.type
        { key: :pas, title: "Publicly Available Specification", short: "PAS" }
      end

      def get_params
        super.merge(type: "PAS")
      end
    end
  end
end
