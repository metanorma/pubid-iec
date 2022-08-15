module Pubid::Iec::Renderer
  class TrfPubid < Pubid
    def render_identifier(params)
      "%{publisher}%{copublisher} TRF%{trf_publisher} %{number}%{part}%{conjuction_part}"\
      "%{part_version}%{version}%{trf_version}%{decision_sheet}%{trf_series}%{test_type}"\
      "%{year}%{vap}" % params
    end

    def render_vap(vap, _opts, _params)
      " #{vap}"
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

    def render_trf_publisher(trf_publisher, _opts, _params)
      " #{trf_publisher}"
    end

    def render_test_type(test_type, _opts, _params)
      "_#{test_type}"
    end

    def render_trf_series(trf_series, _opts, _params)
      "_SE"
    end
  end
end
