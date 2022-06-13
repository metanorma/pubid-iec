module Pubid::Iec
  class Identifier < Pubid::Core::Identifier
    attr_accessor :vap, :database
    class << self
      def get_amendment_class
        Amendment
      end

      def get_corrigendum_class
        Corrigendum
      end

      def get_parser_class
        Parser
      end

      def get_renderer_class
        Renderer
      end
    end
  end
end
