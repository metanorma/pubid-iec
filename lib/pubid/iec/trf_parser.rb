require "pubid-core"

module Pubid::Iec
  class TrfParser < Parser
    rule(:trf_version) do
      (match["A-Z"].maybe >> (str("_") >> match["IVX"].repeat(1)).maybe).as(:trf_version)
    end

    rule(:decision_sheet) do
      (str("_DS") | str("_ds")).as(:decision_sheet)
    end

    rule(:test_type) do
      str("_") >> (str("EMC") | str("SOF") | str("PS")).as(:test_type)
    end

    rule(:part) do
      (str("-") | str("/")) >> space? >> (match['[\d]'] | str("-")).repeat(1).as(:part)
    end

    rule(:trf_series) do
      str("_SE").as(:trf_series)
    end

    rule(:iecee_document_body) do
      str("TRF").as(:type) >> space >>
        (organization.as(:trf_publisher) >> space).maybe >>
        ((digits | str("SYMBOL")) >> match("[A-Z]").maybe).as(:number) >>
        part.maybe >>
        conjuction_part.maybe >>
        trf_version.maybe >>
        test_type.maybe >>
        trf_series.maybe >>
        (space? >> str(":") >> year).maybe
    end

    rule(:iecex_document_body) do
      str("TRF").as(:type) >> space >>
        (organization.as(:trf_publisher) >> space).maybe >>
        ((digits | str("SYMBOL")) >> match("[A-Z]").maybe).as(:number) >>
        part.maybe >>
        edition.maybe >>
        trf_version.maybe >>
        test_type.maybe >>
        decision_sheet.maybe >>
        (space? >> str(":") >> year).maybe
    end

    rule(:identifier) do
      ((str("IECEx").as(:publisher) >> space >> iecex_document_body) |
        (str("IECEE").as(:publisher) >> space >> iecee_document_body)) #>>
        # decision_sheet.maybe >>
        # trf_series.maybe >>
        # edition.maybe >>
        # (str(":") >> year).maybe
    end

    rule(:root) { identifier }
  end
end
