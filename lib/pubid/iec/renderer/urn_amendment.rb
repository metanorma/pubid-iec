require_relative "urn_supplement"

module Pubid::Iec::Renderer
  class UrnAmendment < UrnSupplement
    def render_identifier(params)
      ":amd%{year}%{number}" % params
    end

  end
end
