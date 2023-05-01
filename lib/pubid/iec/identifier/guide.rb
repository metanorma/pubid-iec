module Pubid::Iec
  module Identifier
    class Guide < Base
      def_delegators 'Pubid::Iec::Identifier::Guide', :type

      def self.type
        { key: :guide, title: "Guide", short: %w[Guide GUIDE] }
      end

      def get_params
        super.merge(type: "Guide")
      end
    end
  end
end
