module Pubid::Iec
  module Errors
    class StageParseError < StandardError; end
    class ParseTypeError < StandardError; end
    class WrongTypeError < StandardError; end
    class ProjectStageInvalidError < StandardError; end
    class ProjectStageConversionError < StandardError; end
  end
end
