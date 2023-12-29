module Pubid::Iec
  class Stage < Pubid::Core::Stage

    def initialize(config:, abbr: nil, harmonized_code: nil)
      @config = config
      @abbr = abbr&.to_s

      if harmonized_code
        @harmonized_code = if harmonized_code.is_a?(Pubid::Core::HarmonizedStageCode)
                             harmonized_code
                           else
                             Pubid::Core::HarmonizedStageCode.new(harmonized_code, config: config)
                           end
        @abbr ||= lookup_abbr(@harmonized_code.stages)
      end

      if abbr
        if config.stages["project_stages"].key?(abbr.to_s)
          @harmonized_code ||= Pubid::Core::HarmonizedStageCode.new(config.stages["project_stages"][abbr.to_s], config: config)
          # update abbreviation with identifier's stage
          @abbr = lookup_abbr(@harmonized_code.stages)
        else
          raise Pubid::Core::Errors::StageInvalidError, "#{abbr} is not valid stage" unless config.stages["abbreviations"].key?(abbr.to_s)

          @harmonized_code ||= Pubid::Core::HarmonizedStageCode.new(lookup_code(abbr), config: config)
        end
      end
    end

    def to_s(format = :short)
      case format
      when :short
        empty_abbr? ? "" : abbr
      else
        @harmonized_code.to_s
      end
    end
  end
end
