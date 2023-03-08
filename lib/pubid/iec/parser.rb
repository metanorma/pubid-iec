require "pubid-core"

module Pubid::Iec
  class Parser < Pubid::Core::Parser
    rule(:organization) do
      str("IECEE") | str("IECEx") | str("IECQ") | str("IEC") | str("ISO") |
        str("IEEE") | str("CISPR")
    end

    rule(:stage) do
      array_to_str(Renderer::Urn::STAGES.keys)
    end

    rule(:type) do
      (str("IS") | str("TS") | str("TR") | str("PAS") | str("SRD") |
        str("TEC") | str("STTR") | str("WP") | str("Guide") | str("GUIDE") | str("OD") |
        str("CS") | str("CA")
      ).as(:type)
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
        digits.as(:number) >>
        (str(":") >> digits.as(:year)).maybe).as(:amendments)
    end

    rule(:fragment) do
      (str("/") >> str("FRAG") >> match('[\dA-Z]').repeat(1).as(:fragment)).maybe
    end

    rule(:corrigendum) do
      ((str("/") | space).maybe >>
        str("COR") >>
        digits.as(:number) >>
        (str(":") >> digits.as(:year)).maybe).as(:corrigendums)
    end

    rule(:conjuction_part) do
      ((str(",") | str("&")) >> digits.as(:conjuction_part)).repeat(1)
    end

    rule(:number) do
      (digits | str("SYMBOL") | str("SYCSMARTENERGY") | str("SyCLVDC") |
        str("SYCLVDC") | str("SyCCOMM") | str("SyCAAL") | str("VIM")) >>
        match("[A-Z]").maybe
    end

    rule(:std_document_body) do
      (type >> space).maybe >>
        number.as(:number) >>
        edition.maybe >>
        part.maybe >>
        conjuction_part.maybe >>
        (space? >> str(":") >> year).maybe >>
        ((amendment >> corrigendum.maybe) | corrigendum).repeat >>
        fragment.maybe
    end

    rule(:vap) do
      space >> (str("CSV") | str("SER") | str("RLV") | str("CMV") | str("EXV") |
        str("PAC") | str("PRV")).as(:vap)
    end

    rule(:database) do
      space >> str("DB").as(:database)
    end

    rule(:identifier) do
      (originator.maybe >> (space.maybe >> stage.as(:stage)).maybe >> (space | str("/")) >>
        std_document_body >>
        vap.maybe >> database.maybe >>
        edition.maybe >>
        (str(":") >> year).maybe)
    end

    rule(:root) { identifier }
  end
end
