module Pubid::Iec::Renderer
  class InterpretationSheet < Pubid
    def render_identifier(params)
      type_prefix = params[:stage].nil? || params[:stage].to_s.empty? ? "ISH" : ""

      "%{base}/%{stage}#{type_prefix}%{number}%{year}" % params
    end

    def render_stage(stage, _opts, _params)
      stage
    end

    def render_year(year, _opts, _params)
      ":#{year}"
    end
  end
end
