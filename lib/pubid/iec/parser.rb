require "pubid-core"

module Pubid::Iec
  class Parser < Pubid::Core::Parser
    rule(:organization) do
      str("IECQ") | str("IEC") | str("ISO") | str("IEEE") | str("CISPR") | str("PNW")
    end

    rule(:type) do
      (str("IS") | str("TS") | str("TR") | str("PAS") | str("SRD") |
        str("TEC") | str("STTR") | str("WP") | str("Guide") | str("GUIDE") |
        str("OD") | str("CS")
      ).as(:type)
    end

    rule(:part) do
      (str("-") | str("/")) >> space? >>
        (str("Amd") | str("Cor")).absent? >> (match['[\dA-Z]'] | str("-")).repeat(1).as(:part)
    end

    rule(:version) { digits >> (dot >> digits).maybe }

    rule(:edition) do
      space >> (str("Edition ") >> version.as(:edition) >> space >> year_month.as(:edtion_date) |
        str("ED") >> version.as(:edition))
    end

    rule(:amendment) do
      ((str("/") | str("+") | space).maybe >>
        str("AMD") >>
        digits.as(:version) >>
        (str(":") >> digits.as(:number)).maybe).as(:amendments)
    end

    rule(:fragment) do
      (str("/") >> str("FRAG") >> match('[\dA-Z]').repeat(1).as(:fragment)).maybe
    end

    rule(:corrigendum) do
      ((str("/") | space).maybe >>
        str("COR") >>
        digits.as(:version) >>
        (str(":") >> digits.as(:number)).maybe).as(:corrigendums)
    end

    rule(:number) do
      (digits >> str("A").maybe) | str("SYMBOL")
    end

    rule(:std_document_body) do
      (type >> space).maybe >>
        number.as(:number) >>
        part.maybe >>
        (space? >> str(":") >> year).maybe >>
        ((amendment >> corrigendum.maybe) | corrigendum).repeat >>
        fragment.maybe
    end

    rule(:vap) do
      space >> (str("CSV") | str("SER") | str("RLV")).as(:vap)
    end

    rule(:database) do
      space >> str("DB").as(:database)
    end

    rule(:identifier) do
        originator >> (space | str("/")) >>
        std_document_body >>
        vap.maybe >> database.maybe >>
        edition.maybe
    end

    rule(:root) { identifier }
  end
end
