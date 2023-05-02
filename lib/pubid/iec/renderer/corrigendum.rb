module Pubid::Iec::Renderer
  class Corrigendum < Pubid
    def render_identifier(params)
      "COR%{number}%{year}" % params
    end
  end
end
