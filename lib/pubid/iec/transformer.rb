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
        Amendment
      end

      def get_corrigendum_class
        Corrigendum
      end
    end
  end
end
