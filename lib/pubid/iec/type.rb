module Pubid::Iec
  class Type
    attr_accessor :type

    TYPE_NAMES = {
      is: {
        long: "International Standard",
        short: "IS",
      },
      ts: {
        long: "Technical Specification",
        short: "TS",
      },
      tr: {
        long: "Technical Report",
        short: "TR",
      },
      pas: {
        long: "Publicly Available Specification",
        short: "PAS",
      },
      srd: {
        short: "SRD",
      },
      tec: {
        short: "TEC",
      },
      sttr: {
        short: "STTR",
      },
      wp: {
        short: "WP",
      },
      guide: {
        long: "Guide",
        short: "Guide",
      },
      od: {
        short: "OD",
      },
      cs: {
        short: "CS",
      },
      ca: {
        short: "CA",
      },
      trf: {
        long: "Test Report Form",
        short: "TRF",
      }

    }.freeze

    # Create new type
    # @param type [Symbol]
    def initialize(type = :is)
      type = type.to_s.downcase.to_sym unless type.is_a?(Symbol)

      raise Errors::WrongTypeError, "#{type} type is not available" unless TYPE_NAMES.key?(type)

      @type = type
    end

    def self.parse(type_string)
      TYPE_NAMES.each do |type, values|
        return new(type) if values[:short].upcase == type_string.to_s.upcase
      end
      raise Errors::ParseTypeError, "Cannot parse '#{type_string}' type"
    end

    def to_s(format = :short)
      TYPE_NAMES[type][format]
    end
  end
end
