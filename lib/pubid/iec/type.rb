module Pubid::Iec
  class Type < Pubid::Core::Type

    # # Create new type
    # # @param type [Symbol]
    # def initialize(type = :is)
    #   type = type.to_s.downcase.to_sym unless type.is_a?(Symbol)
    #
    #   raise Errors::WrongTypeError, "#{type} type is not available" unless TYPE_NAMES.key?(type)
    #
    #   @type = type
    # end

    # def self.parse(type_string)
    #   TYPE_NAMES.each do |type, values|
    #     return new(type) if values[:short].upcase == type_string.to_s.upcase
    #   end
    #   raise Errors::ParseTypeError, "Cannot parse '#{type_string}' type"
    # end

    def to_s(format = :short)
      TYPE_NAMES[type][format]
    end
  end
end
