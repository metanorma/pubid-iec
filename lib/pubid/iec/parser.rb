require "pubid-core"

module Pubid::Iec
  class Parser < Pubid::Core::Parser
    rule(:organization) do
      str("IECEE") | str("IECEx") | str("IECQ") | str("IEC") | str("ISO") |
        str("IEEE") | str("CISPR") | str("ASTM")
    end

    rule(:stage) do
      array_to_str(Identifier.config.typed_stages.map { |_, v| v[:abbr] } + Identifier.config.stages["abbreviations"].keys)
    end

    rule(:type) do
      array_to_str(Identifier.config.types.map { |type| type.type[:short] }.flatten.compact).as(:type)
    end

    rule(:part) do
      (str("-") | str("/")) >> space? >>
        (str("Amd") | str("Cor")).absent? >> (match['[\dA-Za-z]'] | str("-")).repeat(1).as(:part)
    end

    rule(:version) { digits >> (dot >> digits).maybe }

    rule(:edition) do
      (str(" Edition ") >> version.as(:edition) >> space >> year_month.as(:edtion_date) |
        str(" ED") >> version.as(:edition) |
        str("v") >> (digits >> (match("[A-Za-z]") >> str("rev").maybe >> digits.maybe).maybe).as(:version))
    end

    rule(:amendment) do
      ((str("/") | str("+") | space).maybe >>
        (str("AMD") | str("A")) >>
        digits.as(:number) >>
        (str(":") >> digits.as(:year)).maybe).as(:amendments)
    end

    rule(:interpretation_sheet) do
      (str("/") >> str("ISH") >>
        digits.as(:number) >>
        (str(":") >> digits.as(:year)).maybe).as(:interpretation_sheet)
    end

    rule(:sheet) do
      (str("/") >> digits.as(:number) >> (str(":") >>
        digits.as(:year)).maybe).as(:sheet)
    end

    rule(:fragment) do
      (str("/") >> str("FRAG") >> match('[\dA-Z]').repeat(1).as(:fragment)).maybe
    end

    rule(:corrigendum) do
      ((str("/") | str(" + ") | space).maybe >>
        str("COR") >>
        digits.as(:number).maybe >>
        (str(":") >> digits.as(:year)).maybe).as(:corrigendums)
    end

    rule(:conjuction_part) do
      ((str(",") | str("&")) >> digits.as(:conjuction_part)).repeat(1)
    end

    rule(:number) do
      (digits | str("SYMBOL") | str("SYCSMARTENERGY") | str("SyCLVDC") |
        str("SYCLVDC") | str("SyCCOMM") | str("SyCAAL") | str("VIM") | match("[A-Za-z0-9 ]").repeat) >>
        ((str(":") >> match("[A-Z]").repeat(1)) | match("[a-zA-Z]")).maybe
    end

    rule(:std_document_body) do
      ((str("/") | space) >> type).maybe >>
        space >> number.as(:number) >>
        edition.maybe >>
        part.maybe >>
        conjuction_part.maybe >>
        (space? >> str(":") >> year >> (str("-") >> month_digits.as(:month) >>
          (str("-") >> day_digits.as(:day)).maybe).maybe).maybe >> sheet.maybe >>
        ((amendment >> vap.maybe >> corrigendum.maybe) | corrigendum).repeat >>
        interpretation_sheet.maybe >> fragment.maybe
    end

    rule(:vap) do
      space >> (str("CSV") | str("SER") | str("RLV") | str("CMV") | str("EXV") |
        str("PAC") | str("PRV")).as(:vap)
    end

    rule(:database) do
      space >> str("DB").as(:database)
    end

    rule(:language) do
      str("(") >> (
        (match["a-z"].repeat(1).as(:language) >> str("-").maybe).repeat(1)
      ) >> str(")")
    end

    rule(:identifier) do
      (originator.maybe >> (space.maybe >> stage.as(:stage)).maybe >>
        std_document_body >>
        vap.maybe >> database.maybe >>
        edition.maybe >>
        (str(":") >> year).maybe >>
        language.maybe)
    end

    rule(:root) { identifier }
  end
end
