module Pubid::Iec
  class Corrigendum < Pubid::Core::Supplement
    def render_pubid
      "COR#{render_pubid_number}"
    end
  end
end
