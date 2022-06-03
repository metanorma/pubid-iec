require "pubid-core"

module Pubid::Iec
  class Parser < Pubid::Core::Parser
    rule(:organization) do
      str("IEC") | str("IEEE") | str("CIW") | str("SAE") |
        str("CIE") | str("ASME") | str("ASTM") | str("OECD") | str("ISO") |
        str("IWA") | str("HL7") | str("CEI")
    end

    rule(:type) do
      (str("DATA") | str("ISP") | str("IWA") | str("R") | str("TTA") |
        str("TS") | str("TR") | str("PAS") | str("Guide") | str("GUIDE")
      ).as(:type)
    end

    rule(:stage) do
      # other stages
      str("NP") | str("WD") | str("CD") | str("DIS") | str("FDIS") | str("PRF") |
        str("IS") | str("AWI") | str("PWI") |
        # AMD and COR stages
        str("FPD") | str("pD") | str("PD") | str("FD") | str("D")
    end

    rule(:part) do
      (str("-") | str("/")) >> space? >>
        (str("Amd") | str("Cor")).absent? >> (match['[\dA-Z]'] | str("-")).repeat(1).as(:part)
    end

    rule(:version) { digits >> dot >> digits }

    rule(:edition) do
      space >> str("Edition ") >> version.as(:edition) >> space >> year_month.as(:edtion_date)
    end

    rule(:std_document_body) do
      (type | stage.as(:stage)).maybe >>
        # for ISO/IEC WD TS 25025
        space? >> ((stage.as(:stage) | type) >> space).maybe >>
        digits.as(:number) >>
        # for identifiers like ISO 5537/IDF 26
        (str("|") >> (str("IDF") >> space >> digits).as(:joint_document)).maybe >>
        part.maybe >>
        (space? >> str(":") >> year).maybe >>
        # stage before amendment
        edition.maybe
    end

    rule(:identifier) do
        originator >> (space | str("/")) >>
        std_document_body
    end

    rule(:root) { identifier }
  end
end
