module Pubid::Iec
  class Identifier < Pubid::Core::Identifier
    attr_accessor :redline, :vap, :database
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

      def get_transformer_class
        Transformer
      end
    end

    def database
      @database || false
    end
  end
end
