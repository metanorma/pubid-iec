require "pubid-core"

module Pubid::Iec
  class Parser < Pubid::Core::Parser
    rule(:organization) do
      str("IECEE") | str("IECEx") | str("IECQ") | str("IEC") | str("ISO") |
        str("IEEE") | str("CISPR") | str("PNW")
    end

    rule(:type) do
      (str("TRF") | str("IS") | str("TS") | str("TR") | str("PAS") | str("SRD") |
        str("TEC") | str("STTR") | str("WP") | str("Guide") | str("GUIDE") | str("OD") |
        str("CS") | str("CA")
      ).as(:type)
    end

    rule(:test_type) do
      str("_") >> (str("EMC") | str("SOF") | str("PS")).as(:test_type)
    end

    rule(:part) do
      (str("-") | str("/")) >> space? >>
        (str("Amd") | str("Cor")).absent? >> (match['[\dA-Z]'] | str("-")).repeat(1).as(:part)
    end

    rule(:version) { digits >> (dot >> digits).maybe }

    rule(:edition) do
      (str(" Edition ") >> version.as(:edition) >> space >> year_month.as(:edtion_date) |
        str(" ED") >> version.as(:edition) |
        str("v") >> (digits >> (match("[A-Za-z]") >> str("rev").maybe >> digits.maybe).maybe).as(:version))
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

    rule(:decision_sheet) do
      (str("_DS") | str("_ds")).as(:decision_sheet)
    end

    rule(:conjuction_part) do
      (str(",") >> digits.as(:conjuction_part)).repeat(1)
    end

    rule(:trf_version) do
      (match["A-Z"].maybe >> (str("_") >> match["IVX"].repeat(1)).maybe).as(:trf_version)
    end

    rule(:std_document_body) do
      (type >> space).maybe >>
        (organization.as(:trf_publisher) >> space).maybe >>
        ((digits | str("SYMBOL")) >> match("[A-Z]").maybe).as(:number) >>
        edition.maybe >>
        part.maybe >>
        conjuction_part.maybe >>
        trf_version.maybe >>
        test_type.maybe >>
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
        edition.maybe >>
        decision_sheet.maybe >>
        (str(":") >> year).maybe
    end

    rule(:root) { identifier }
  end
end
