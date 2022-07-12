module Pubid::Iec
  class Renderer < Pubid::Core::Renderer::Base
    def render_identifier(params)
      "%{publisher}%{copublisher}%{type}%{stage}%{trf_publisher} %{number}%{part}%{conjuction_part}%{part_version}"\
      "%{version}%{iteration}%{decision_sheet}"\
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

    def render_version(version, _opts, params)
      "v#{params[:edition]}#{version}"
    end

    def render_edition(edition, _opts, params)
      " ED#{edition}" unless params[:version]
    end

    def render_conjuction_part(conjuction_parts, _opts, _params)
      if conjuction_parts.is_a?(Array)
        conjuction_parts.map(&:to_i).sort.map { |conjuction_part| ",#{conjuction_part}" }.join
      else
        ",#{conjuction_parts}"
      end
    end

    def render_trf_publisher(trf_publisher, _opts, _params)
      " #{trf_publisher}"
    end
  end
end
