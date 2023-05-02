module Pubid::Iec
  class Transformer < Pubid::Core::Transformer
    def initialize
      super

      rule(database: "DB") do
        { database: true }
      end
    end

    class << self
      def get_amendment_class
        Identifier::Amendment
      end

      def get_corrigendum_class
        Identifier::Corrigendum
      end
    end
  end
end
