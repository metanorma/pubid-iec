require "parslet"
require "yaml"

module Pubid
  module Iec
    UPDATE_CODES = YAML.load_file(File.join(File.dirname(__FILE__), "../../update_codes.yaml"))
  end
end

require "pubid-core"
require_relative "iec/errors"
require_relative "iec/stage"
require_relative "iec/typed_project_stage"
require_relative "iec/parser"
require_relative "iec/trf_parser"
require_relative "iec/renderer/pubid"
require_relative "iec/renderer/trf_pubid"
require_relative "iec/renderer/urn"
require_relative "iec/renderer/trf_urn"
require_relative "iec/renderer/working_document"
require_relative "iec/renderer/working_document_urn"
require_relative "iec/renderer/interpretation_sheet"
require_relative "iec/transformer"
require_relative "iec/identifier/base"
require_relative "iec/identifier/international_standard"
require_relative "iec/identifier/technical_report"
require_relative "iec/identifier/technical_specification"
require_relative "iec/identifier/publicly_available_specification"
require_relative "iec/identifier/guide"
require_relative "iec/identifier/operational_document"
require_relative "iec/identifier/component_specification"
require_relative "iec/identifier/systems_reference_document"
require_relative "iec/identifier/conformity_assessment"
require_relative "iec/identifier/test_report_form"
require_relative "iec/identifier/supplement"
require_relative "iec/identifier/amendment"
require_relative "iec/identifier/corrigendum"
require_relative "iec/identifier/white_paper"
require_relative "iec/identifier/technology_report"
require_relative "iec/identifier/societal_technology_trend_report"
require_relative "iec/identifier/interpretation_sheet"
require_relative "iec/working_document_parser"
require_relative "iec/identifier/working_document"
require_relative "iec/trf_identifier"
require_relative "iec/identifier"
require_relative "iec/working_document"
require_relative "iec/configuration"

config = Pubid::Iec::Configuration.new
config.stages = YAML.load_file(File.join(File.dirname(__FILE__), "../../stages.yaml"))
config.stage_class = Pubid::Iec::Stage
config.default_type = Pubid::Iec::Identifier::InternationalStandard
config.types = [Pubid::Iec::Identifier::InternationalStandard,
                Pubid::Iec::Identifier::TechnicalReport,
                Pubid::Iec::Identifier::TechnicalSpecification,
                Pubid::Iec::Identifier::PubliclyAvailableSpecification,
                Pubid::Iec::Identifier::Guide,
                Pubid::Iec::Identifier::OperationalDocument,
                Pubid::Iec::Identifier::ComponentSpecification,
                Pubid::Iec::Identifier::SystemsReferenceDocument,
                Pubid::Iec::Identifier::ConformityAssessment,
                Pubid::Iec::Identifier::TestReportForm,
                Pubid::Iec::Identifier::WritePaper,
                Pubid::Iec::Identifier::TechnologyReport,
                Pubid::Iec::Identifier::SocietalTechnologyTrendReport,
                Pubid::Iec::Identifier::InterpretationSheet]

Pubid::Iec::Identifier.set_config(config)
