module Pubid::Iec::Renderer
  class WorkingDocumentUrn < Urn

    def render_identifier(params)
      "urn:iec:working-document:%{technical_committee}:%{number}%{stage}" % params
    end

    def render_technical_committee(technical_committee, _opts, _params)
      technical_committee.to_s.gsub("/", "-").downcase
    end

    def render_stage(stage, _opts, _params)
      ":stage-#{stage.to_s.downcase}"
    end
  end
end
