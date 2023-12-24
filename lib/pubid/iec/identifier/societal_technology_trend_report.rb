# frozen_string_literal: true
module Pubid::Iec
  module Identifier
    class SocietalTechnologyTrendReport < Base
      def_delegators 'Pubid::Iec::Identifier::SocietalTechnologyTrendReport', :type

      def self.type
        { key: :sttr, title: "Societal and Technology Trend Report", short: "Trend Report" }
      end

      def to_h(deep: false)
        super.merge(type: "Trend Report")
      end
    end
  end
end
