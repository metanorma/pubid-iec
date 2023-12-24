module Pubid::Iec::Renderer
  class Urn < ::Pubid::Core::Renderer::Urn
    STAGES = { ACD: 20.99,
               ACDV: 30.99,
               ADTR: 40.99,
               ADTS: 40.99,
               AFDIS: 40.99,
               APUB: 50.99,
               BPUB: 60,
               CAN: 30.98,
               CCDV: 40.20,
               CD: 30.20,
               CDISH: 50.20,
               CDM: 30.60,
               CDPAS: 50.20,
               CDTR: 50.20,
               CDTS: 50.20,
               CDVM: 40.91,
               CFDIS: 50.20,
               DECDISH: 50.00,
               DECFDIS: 50.00,
               DECPUB: 60.00,
               DEL: 10.98,
               DELPUB: 99.60,
               DTRM: 50.92,
               DTSM: 50.92,
               MERGED: 30.97,
               NCDV: 40.91,
               NDTR: 50.92,
               NDTS: 50.92,
               NFDIS: 50.92,
               PCC: 30.60,
               PNW: 10.20,
               PPUB: 60.60,
               PRVC: 40.60,
               PRVD: 50.60,
               PRVDISH: 50.60,
               PRVDPAS: 50.60,
               PRVDTR: 50.60,
               PRVDTS: 50.60,
               PRVN: 10.60,
               PWI: 0,
               RDISH: 50.00,
               RFDIS: 50.00,
               RPUB: 60.00,
               SPLIT: 30.96,
               TCDV: 40.00,
               TDISH: 50.00,
               TDTR: 50.00,
               TDTS: 50.00,
               TPUB: 60.00,
               WPUB: 95.99
    }.freeze

    def render_identifier(params)
      "urn:iec:std:%{publisher}%{copublisher}%{type}:%{number}"\
      "%{part}%{conjuction_part}%{year}%{stage}%{vap}"\
      "%{urn_stage}%{corrigendum_stage}%{iteration}%{version}%{part_version}"\
      "%{edition}%{amendments}%{corrigendums}%{fragment}" % params
    end

    def render_number(number, _opts, _params)
      number.to_s.downcase
    end

    def render_vap(vap, _opts, _params)
      ":#{vap.downcase}"
    end

    def render_fragment(fragment, _opts, _params)
      ":frag:#{fragment}"
    end

    def render_version(version, _opts, _params)
      ":v#{version}"
    end

    def render_part_version(part_version, _opts, _params)
      ":v#{part_version}"
    end

    def render_conjuction_part(conjuction_parts, _opts, _params)
      if conjuction_parts.is_a?(Array)
        conjuction_parts.map(&:to_i).sort.map { |conjuction_part| ",#{conjuction_part}" }.join
      else
        ",#{conjuction_parts}"
      end
    end

    def render_stage(stage, _opts, params)
      ":stage-#{sprintf('%s', stage.to_s(:urn))}"
    end

    def render_type(type, _, _)
      ":#{type.downcase}"
    end

    def render_amendments(amendments, _opts, _params)
      amendments&.map(&:urn)&.join || ""
    end

    def render_corrigendums(corrigendums, _opts, _params)
      corrigendums&.map(&:urn)&.join || ""
    end

    def render_language(language, _opts, _params)
      ":" + (language.is_a?(Array) ? language.join("-") : language)
    end

  end
end
