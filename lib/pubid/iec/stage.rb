module Pubid::Iec
  class Stage
    STAGES = { ACD: "20.99",
               ACDV: "30.99",
               ADTR: "40.99",
               ADTS: "40.99",
               AFDIS: "40.99",
               APUB: "50.99",
               BPUB: "60.00",
               CAN: "30.98",
               CCDV: "40.20",
               CD: "30.20",
               CDISH: "50.20",
               CDM: "30.60",
               CDPAS: "50.20",
               CDTR: "50.20",
               CDTS: "50.20",
               CDVM: "40.91",
               CFDIS: "50.20",
               DECDISH: "50.00",
               DECFDIS: "50.00",
               DECPUB: "60.00",
               DEL: "10.98",
               DELPUB: "99.60",
               DTRM: "50.92",
               DTSM: "50.92",
               MERGED: "30.97",
               NCDV: "40.91",
               NDTR: "50.92",
               NDTS: "50.92",
               NFDIS: "50.92",
               PCC: "30.60",
               PNW: "10.20",
               PPUB: "60.60",
               PRVC: "40.60",
               PRVD: "50.60",
               PRVDISH: "50.60",
               PRVDPAS: "50.60",
               PRVDTR: "50.60",
               PRVDTS: "50.60",
               PRVN: "10.60",
               PWI: "00.00",
               RDISH: "50.00",
               RFDIS: "50.00",
               RPUB: "60.00",
               SPLIT: "30.96",
               TCDV: "40.00",
               TDISH: "50.00",
               TDTR: "50.00",
               TDTS: "50.00",
               TPUB: "60.00",
               WPUB: "95.99"
    }.freeze

    attr_accessor :stage

    def initialize(stage)
      raise Errors::StageInvalidError, "#{stage} is not valid stage" unless STAGES.key?(stage.to_sym)

      @stage = stage
    end

    def to_s(format = :short)
      return "" if nil?

      case format
      when :short
        @stage
      else
        STAGES[@stage.to_sym]
      end
    end

    def nil?
      @stage.nil?
    end

    def self.parse(stage)
      raise Errors::StageInvalidError unless stage.is_a?(Symbol) || stage.is_a?(String) || stage.is_a?(Parslet::Slice)

      Stage.new(stage.to_s)
    end
  end
end
