module Pubid::Iec
  module Errors
    class StageParseError < StandardError; end
    class StageInvalidError < StandardError; end
    class ParseTypeError < StandardError; end
    class WrongTypeError < StandardError; end
  end
end