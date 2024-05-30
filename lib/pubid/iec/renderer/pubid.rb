module Pubid::Iec::Renderer
  class Pubid < Pubid::Core::Renderer::Base
    def render_identifier(params)
      "%{publisher}%{type}%{typed_stage}%{stage} %{number}%{part}%{conjuction_part}"\
      "%{part_version}%{version}%{iteration}"\
      "%{year}%{month}%{day}%{sheet}%{amendments}%{corrigendums}%{fragment}%{vap}%{edition}%{database}" % params
    end
    def render_typed_stage(typed_stage, _opts, _params)
      " #{typed_stage}"
    end

    def render_type(type, _opts, params)
      return if params[:stage].is_a?(::Pubid::Core::TypedStage)

      " #{type}"
    end

    def render_vap(vap, _opts, _params)
      " #{vap}"
    end

    def render_stage(stage, _opts, params)
      return if params[:typed_stage] || stage.abbr.nil?

      " #{stage}"
    end

    def render_fragment(fragment, _opts, _params)
      "/FRAG#{fragment}"
    end

    def render_sheet(sheet, _opts, _params)
      "/#{sheet[:number]}" + (sheet[:year] ? ":#{sheet[:year]}" : "")
    end

    def render_database(database, _opts, _params)
      " DB" if database
    end

    def supplement_prefix(params)
      params[:vap] == "CSV" && "+" || "/"
    end

    def render_amendments(amendments, _opts, _params)
      supplement_prefix(params) + amendments.sort.map(&:to_s).join("+")
    end

    def render_corrigendums(corrigendums, _opts, _params)
      supplement_prefix(params) + corrigendums.sort.map(&:to_s).join("+")
    end

    def render_version(version, _opts, params)
      "v#{params[:edition]}#{version}"
    end

    def render_edition(edition, _opts, params)
      " ED#{edition}" unless params[:version]
    end

    def render_conjuction_part(conjuction_parts, _opts, _params)
      conjunction_symbol = case _params[:publisher]
      when "IECEE"
        # IECEE TRFs use '&' as parts separator (IECEE OD-2020)
        "&"
      else
        # when "IECEx"
        # IECEx TRFs use ',' as parts separator (IECEx OD-010-1)
        ","
      end

      if conjuction_parts.is_a?(Array)
        conjuction_parts.map(&:to_i).sort.map { |conjuction_part| "#{conjunction_symbol}#{conjuction_part}" }.join
      else
        "#{conjunction_symbol}#{conjuction_parts}"
      end
    end

    def render_month(month, opts, _params)
      "-#{month}" if opts[:with_edition_month_date]
    end

    def render_day(day, opts, _params)
      "-#{day}" if opts[:with_edition_month_date]
    end

    def render_language(language, opts, _params)
      if language.is_a?(Array)
        "(#{language.map(&:to_s).sort.join('-')})"
      else
        "(#{language})"
      end
    end
  end
end
