module Pubid::Iec::Renderer
  class InterpretationSheet < Pubid
    def render_identifier(params)
      "%{base}/ISH%{number}%{year}" % params
    end

    def render_year(year, _opts, _params)
      ":#{year}"
    end
  end
end
