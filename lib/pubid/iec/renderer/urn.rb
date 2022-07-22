module Pubid::Iec::Renderer
  class Urn < ::Pubid::Core::Renderer::Urn
    def render_identifier(params)
      "urn:iec:std:%{publisher}%{copublisher}%{type}%{trf_publisher}:%{number}"\
      "%{part}%{conjuction_part}%{year}%{stage}%{vap}"\
      "%{urn_stage}%{corrigendum_stage}%{iteration}%{version}%{part_version}"\
      "%{trf_version}%{edition}%{amendments}%{corrigendums}%{fragment}%{language}" % params
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

    def render_trf_version(trf_version, _opts, _params)
      ":v#{trf_version}" unless trf_version.empty?
    end

    def render_conjuction_part(conjuction_parts, _opts, _params)
      if conjuction_parts.is_a?(Array)
        conjuction_parts.map(&:to_i).sort.map { |conjuction_part| ",#{conjuction_part}" }.join
      else
        ",#{conjuction_parts}"
      end
    end

    def render_trf_publisher(trf_publisher, _opts, _params)
      ":#{trf_publisher.downcase}"
    end
  end
end
