require_relative "../renderer/corrigendum"
require_relative "../renderer/urn_corrigendum"

module Pubid::Iec
  module Identifier
    class Corrigendum < Supplement
      def_delegators 'Pubid::Iec::Identifier::Corrigendum', :type

      def self.type
        { key: :cor, title: "Corrigendum" }
      end

      def self.get_renderer_class
        Renderer::Corrigendum
      end

      def urn
        Renderer::UrnCorrigendum.new(get_params).render
      end
    end
  end
end
