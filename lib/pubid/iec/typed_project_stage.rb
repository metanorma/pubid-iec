module Pubid::Iec
  class TypedProjectStage < Stage
    attr_accessor :config, :abbr

    # @param config [Configuration]
    # @param abbr [Symbol] typed stage symbol, e.g. :dtr
    # @param harmonized_code [String, Float, HarmonizedStageCode]
    def initialize(config:, abbr:, harmonized_code: nil)
      @config = config
      @abbr = abbr

      if harmonized_code
        @harmonized_code = if harmonized_code.is_a?(Pubid::Core::HarmonizedStageCode)
                             harmonized_code
                           else
                             Pubid::Core::HarmonizedStageCode.new(harmonized_code, config: config)
                           end
      end

      raise Errors::ProjectStageInvalidError, "#{abbr} is not valid project stage" unless config.typed_project_stages.any? { |k, v| v[:abbr] == abbr }
    end

    # Compares one stage with another
    # should return false if
    def ==(other)
      return false unless other.is_a?(self.class)

      other&.harmonized_code == harmonized_code
    end

    def to_s(_opts = nil)
      abbr
      # config.typed_project_stages[abbr][:abbr]
    end
  end
end
