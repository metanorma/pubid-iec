module Pubid::Iec
  module Identifier
    class TestReportForm < Base

      attr_accessor :version, :decision_sheet,
                    :conjuction_part, :part_version, :trf_publisher,
                    :trf_series, :trf_version, :test_type

      def initialize(publisher: "IEC", decision_sheet: nil, trf_publisher: nil,
                     trf_series: nil, trf_version: nil, test_type: nil,
                     **args)
        @decision_sheet = decision_sheet if decision_sheet
        @trf_publisher = trf_publisher.to_s if trf_publisher
        @trf_series = trf_series if trf_series
        @trf_version = trf_version.to_s if trf_version
        @test_type = test_type if test_type

        super(**args.merge(publisher: publisher))
      end

      def self.type
        { key: :trf, title: "Test Report Form", short: "TRF" }
      end

      def urn
        Renderer::TrfUrn.new(renderer_data).render
      end

      class << self
        def get_parser_class
          TrfParser
        end

        def get_renderer_class
          Renderer::TrfPubid
        end
      end
    end
  end
end
