require "pubid-core"

module Pubid::Iec
  class Parser < Pubid::Core::Parser
    rule(:organization) do
      str("IEC") | str("ISO") | str("IEEE") | str("CISPR")
    end

    rule(:type) do
      (str("IS") | str("TS") | str("TR") | str("PAS") | str("SRD") |
        str("TEC") | str("STTR") | str("WP") | str("Guide") | str("GUIDE")
      ).as(:type)
    end

    rule(:part) do
      (str("-") | str("/")) >> space? >>
        (str("Amd") | str("Cor")).absent? >> (match['[\dA-Z]'] | str("-")).repeat(1).as(:part)
    end

    rule(:version) { digits >> dot >> digits }

    rule(:edition) do
      space >> str("Edition ") >> version.as(:edition) >> space >> year_month.as(:edtion_date)
    end

    rule(:amendment) do
        (str("/") | str("+") | space).maybe >>
        str("AMD").as(:amendment) >>
        digits.as(:amendment_version) >>
        (str(":") >> digits.as(:amendment_number)).maybe
    end

    rule(:corrigendum) do
        (str("/") | space).maybe >>
        (str("Cor") | str("COR")).as(:corrigendum) >>
        digits.as(:corrigendum_version) >>
        (str(":") >> digits.as(:corrigendum_number)).maybe
    end

    rule(:std_document_body) do
      (type >> space).maybe >>
        (digits | str("SYMBOL")).as(:number) >>
        part.maybe >>
        (space? >> str(":") >> year).maybe >>
        ((amendment >> corrigendum.maybe) | corrigendum).repeat >>
        edition.maybe
    end

    rule(:redline) do
      space >> str("RLV").as(:redline)
    end

    rule(:vap) do
      space >> (str("CSV") | str("SER")).as(:vap)
    end

    rule(:database) do
      space >> str("DB").as(:database)
    end

    rule(:identifier) do
        originator >> (space | str("/")) >>
        std_document_body >> redline.maybe >>
        vap.maybe >> database.maybe
    end

    rule(:root) { identifier }
  end
end
