module Pubid::Iec::Renderer
  class WorkingDocument < Pubid
    def render_identifier(params)
      "%{technical_committee}/%{number}%{stage}" % params
    end

    def render_stage(stage, _opts, _params)
      "/#{stage}"
    end
  end
end
