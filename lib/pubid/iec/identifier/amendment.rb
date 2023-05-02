require_relative "../renderer/amendment"
require_relative "../renderer/urn_amendment"

module Pubid::Iec
  module Identifier
    class Amendment < Supplement
      def_delegators 'Pubid::Iec::Identifier::Amendment', :type

      def self.type
        { key: :amd, title: "Amendment" }
      end

      def self.get_renderer_class
        Renderer::Amendment
      end

      def urn
        Renderer::UrnAmendment.new(get_params).render
      end
    end
  end
end
