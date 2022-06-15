module Pubid::Iec
  class Renderer < Pubid::Core::Renderer::Base
    def render_identifier(params)
      "%{publisher}%{copublisher}%{type}%{stage} %{number}%{part}%{iteration}"\
      "%{year}%{amendments}%{corrigendums}%{fragment}%{vap}%{edition}%{language}%{database}" % params
    end

    def render_type(type, _opts, _params)
      " #{type}"
    end

    def render_vap(vap, _opts, _params)
      " #{vap}"
    end

    def render_fragment(fragment, _opts, _params)
      "/FRAG#{fragment}"
    end

    def render_database(database, _opts, _params)
      " DB" if database
    end

    def supplement_prefix(params)
      params[:vap] == "CSV" && "+" || "/"
    end

    def render_amendments(amendments, _opts, params)
      supplement_prefix(params) + super
    end

    def render_corrigendums(corrigendums, _opts, params)
      supplement_prefix(params) + super
    end
  end
end
