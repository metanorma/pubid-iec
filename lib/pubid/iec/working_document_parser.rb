require "pubid-core"

module Pubid::Iec
  class WorkingDocumentParser < Pubid::Core::Parser
    rule(:stage) do
      array_to_str(Identifier::WorkingDocument::STAGES).as(:stage)
    end

    rule(:technical_committee) do
      ((str("CIS/") >> match("[A-Z]")) |
      (match("[A-Za-z0-9-]").repeat(1))).as(:technical_committee)
    end

    rule(:number) do
      (digits >> match("[A-Z]").maybe >> str("(F)").maybe).as(:number)
    end

    rule(:identifier) do
      technical_committee >> str("/") >> number >> (str("/") >> stage).maybe
    end

    rule(:root) { identifier }
  end
end
