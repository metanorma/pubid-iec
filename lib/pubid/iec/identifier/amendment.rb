require_relative "../renderer/amendment"
require_relative "../renderer/urn_amendment"

module Pubid::Iec
  module Identifier
    class Amendment < Supplement
      def_delegators 'Pubid::Iec::Identifier::Amendment', :type

      TYPED_STAGES = {
        cdam: {
          abbr: "CDAM",
          name: "Committee Draft Ammendment",
          harmonized_stages: %w[30.00 30.20 30.60 30.92 30.98 30.99],
        },
        dcor: {
          abbr: "DAM",
          name: "Draft Ammendment",
          harmonized_stages: %w[40.00 40.20 40.60 40.92 40.98 40.99],
        },
        fdcor: {
          abbr: "FDAM",
          name: "Final Draft Ammendment",
          harmonized_stages: %w[50.00 50.20 50.60 50.92 50.98 50.99],
        }
      }.freeze

      def self.type
        { key: :amd, title: "Amendment" }
      end

      def self.get_renderer_class
        Renderer::Amendment
      end

      def urn
        Renderer::UrnAmendment.new(renderer_data).render
      end
    end
  end
end
