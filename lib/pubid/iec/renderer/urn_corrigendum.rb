require_relative "urn_supplement"

module Pubid::Iec::Renderer
  class UrnCorrigendum < UrnSupplement
    def render_identifier(params)
      ":cor%{year}%{number}" % params
    end
  end
end
