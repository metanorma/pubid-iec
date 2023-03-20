module Pubid::Iec
  class Stage < Pubid::Core::Stage

    def to_s(format = :short)
      return "" if empty_abbr?

      case format
      when :short
        abbr
      else
        @harmonized_code.to_s
      end
    end
  end
end
