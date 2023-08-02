module Pubid::Iec::Renderer
  class InterpretationSheet < Pubid
    def render_identifier(params)
      type_prefix = params[:typed_stage].nil? || params[:typed_stage].empty? ? "ISH" : ""

      "%{base}/%{typed_stage}#{type_prefix}%{number}%{year}" % params
    end

    def render_typed_stage(typed_stage, _opts, _params)
      typed_stage
    end

    def render_year(year, _opts, _params)
      ":#{year}"
    end
  end
end
