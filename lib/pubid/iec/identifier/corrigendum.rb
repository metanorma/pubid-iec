require_relative "../renderer/corrigendum"
require_relative "../renderer/urn_corrigendum"

module Pubid::Iec
  module Identifier
    class Corrigendum < Supplement
      def_delegators 'Pubid::Iec::Identifier::Corrigendum', :type

      TYPED_STAGES = {
        cdcor: {
          abbr: "CDCor",
          name: "Committee Draft Corrigendum",
          harmonized_stages: %w[30.00 30.20 30.60 30.92 30.98 30.99],
        },
        dcor: {
          abbr: "DCOR",
          name: "Draft Corrigendum",
          harmonized_stages: %w[40.00 40.20 40.60 40.92 40.98 40.99],
        },
        fdcor: {
          abbr: "FDCOR",
          name: "Final Draft Corrigendum",
          harmonized_stages: %w[50.00 50.20 50.60 50.92 50.98 50.99],
        }
      }.freeze

      def self.type
        { key: :cor, title: "Corrigendum" }
      end

      def self.get_renderer_class
        Renderer::Corrigendum
      end

      def urn
        Renderer::UrnCorrigendum.new(renderer_data).render
      end
    end
  end
end
