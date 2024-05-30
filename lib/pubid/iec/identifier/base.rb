require "forwardable"

module Pubid::Iec
  class Base < Pubid::Core::Identifier::Base

    attr_accessor :vap, :database, :fragment, :version, :decision_sheet,
                  :conjuction_part, :part_version, :trf_publisher,
                  :trf_series, :trf_version, :test_type, :month, :day, :sheet

    extend Forwardable

    PROJECT_STAGES = {}.freeze

    # @param stage [String] stage eg. "PWI", "PNW"
    def initialize(publisher: "IEC", vap: nil, database: nil,
                   fragment: nil, version: nil, decision_sheet: nil,
                   conjuction_part: nil, part_version: nil, trf_publisher: nil,
                   trf_series: nil, trf_version: nil, test_type: nil,
                   edition: nil, type: nil, month: nil, day: nil,
                   language: nil, stage: nil, sheet: nil, **args)

      @vap = vap.to_s if vap
      @database = database if database
      @fragment = fragment if fragment
      @version = version if version
      @decision_sheet = decision_sheet if decision_sheet
      @conjuction_part = conjuction_part if conjuction_part
      @part_version = part_version if part_version
      @trf_publisher = trf_publisher.to_s if trf_publisher
      @trf_series = trf_series if trf_series
      @trf_version = trf_version.to_s if trf_version
      @test_type = test_type if test_type
      @edition = edition.to_s if edition
      @month = month if month
      @day = day if day
      @language = language if language
      @sheet = sheet if sheet

      if stage
        @stage = self.class.has_project_stage?(stage) ? self.class.resolve_project_stage(stage) : resolve_stage(stage)
      end

      super(**args.merge(publisher: publisher))
    end

    def urn
      Renderer::Urn.new(renderer_data).render
    end

    def lookup_typed_stage(lookup_code)
      self.class::TYPED_STAGES.each do |abbr, stage|
        if stage[:harmonized_stages] & lookup_code == lookup_code
          return Identifier.build_typed_stage(abbr: abbr, harmonized_code: lookup_code)
        end
      end

      nil
    end

    def renderer_data
      values = to_h(deep: false)

      # convert project stage to typed stage
      if values.key?(:stage) && values[:stage].is_a?(TypedProjectStage)
        values[:stage] = lookup_typed_stage(values[:stage].harmonized_code.stages) ||
          resolve_stage(values[:stage].harmonized_code.stages.first)
      end
      values
    end

    def to_s(with_edition_month_date: false)
      self.class.get_renderer_class.new(renderer_data).render(with_edition_month_date: with_edition_month_date)
    end

    class << self
      def has_project_stage?(project_stage)
        self::PROJECT_STAGES.any? { |k, v| v[:abbr] == project_stage }
      end

      def has_type?(type)
        return type == self.type[:key] if type.is_a?(Symbol)

        if self.type.key?(:short)
          self.type[:short].is_a?(Array) ? self.type[:short].include?(type) : self.type[:short] == type
        else
          type.to_s.downcase.to_sym == self.type[:key]
        end
      end

      def resolve_project_stage(project_stage)
        stage = self::PROJECT_STAGES.find do |k, v|
          v[:abbr] == project_stage
        end

        Identifier.build_project_stage(abbr: stage[1][:abbr], harmonized_code: stage[1][:harmonized_stages])
      end

      def transform_hash(params)
        params.map do |k, v|
          get_transformer_class.new.apply(k => v.is_a?(Hash) ? transform_hash(v) : v)
        end.inject({}, :merge)
      end

      def transform(params)
        identifier_params = transform_hash(params)

        if identifier_params[:interpretation_sheet]
          return Identifier.create(
            type: :ish,
            base: Identifier.create(
              **identifier_params.dup.tap { |h| h.delete(:interpretation_sheet) }),
            number: identifier_params[:interpretation_sheet][:number],
            year: identifier_params[:interpretation_sheet][:year]
          )
        end

        Identifier.create(**identifier_params)
      end

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
        Renderer::Pubid
      end

      def get_transformer_class
        Transformer
      end

      def get_update_codes
        UPDATE_CODES
      end

      def get_identifier
        Identifier
      end
    end

    def database
      @database || false
    end
  end
end
