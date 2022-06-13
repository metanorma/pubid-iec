module Pubid::Iec
  class Amendment < Pubid::Core::Supplement
    def render_pubid
      "AMD#{render_pubid_number}"
    end
  end
end
