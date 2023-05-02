module Pubid::Iec
  module Identifier
    class Supplement < Base
      def initialize(number:, year: nil)
        @number, @year = number&.to_i, year&.to_i
      end

      def <=>(other)
        return 0 if year.nil? && other.year

        return year <=> other.year if number == other.number

        (number <=> other.number) || year <=> other.year
      end
    end
  end
end
