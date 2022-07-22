module Pubid::Iec
  class Amendment < Pubid::Core::Supplement
    def render_pubid
      "AMD#{render_pubid_number}"
    end

    def render_urn
      ":amd#{render_urn_number}"
    end
  end
end
