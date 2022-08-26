module Pubid::Iec
  class Transformer < Pubid::Core::Transformer
    class << self
      def get_amendment_class
        Amendment
      end

      def get_corrigendum_class
        Corrigendum
      end
    end

    def initialize
      super

      rule(database: "DB") do
        { database: true }
      end
    end
  end
end
