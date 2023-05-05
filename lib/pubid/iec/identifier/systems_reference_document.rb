module Pubid::Iec
  module Identifier
    class SystemsReferenceDocument < Base
      def_delegators 'Pubid::Iec::Identifier::SystemsReferenceDocument', :type

      def self.type
        { key: :srd, title: "Systems Reference Document", short: "SRD" }
      end

      def get_params
        super.merge(type: "SRD")
      end
    end
  end
end
