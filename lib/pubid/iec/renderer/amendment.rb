module Pubid::Iec::Renderer
  class Amendment < Pubid
    def render_identifier(params)
      "AMD%{number}%{year}" % params
    end
  end
end
