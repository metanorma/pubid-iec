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
# require_relative "iec/type"
require_relative "iec/parser"
require_relative "iec/trf_parser"
require_relative "iec/amendment"
require_relative "iec/corrigendum"
require_relative "iec/renderer/pubid"
require_relative "iec/renderer/trf_pubid"
require_relative "iec/renderer/urn"
require_relative "iec/renderer/trf_urn"
require_relative "iec/transformer"
require_relative "iec/identifier/base"
require_relative "iec/trf_identifier"
require_relative "iec/identifier"

config = Pubid::Core::Configuration.new
config.stages = YAML.load_file(File.join(File.dirname(__FILE__), "../../stages.yaml"))
config.stage_class = Pubid::Iec::Stage
config.type_names = { is: {
                        long: "International Standard",
                        short: "IS",
                      },
                      ts: {
                        long: "Technical Specification",
                        short: "TS",
                      },
                      tr: {
                        long: "Technical Report",
                        short: "TR",
                      },
                      pas: {
                        long: "Publicly Available Specification",
                        short: "PAS",
                      },
                      srd: {
                        short: "SRD",
                      },
                      tec: {
                        short: "TEC",
                      },
                      sttr: {
                        short: "STTR",
                      },
                      wp: {
                        short: "WP",
                      },
                      guide: {
                        long: "Guide",
                        short: "Guide",
                      },
                      od: {
                        short: "OD",
                      },
                      cs: {
                        short: "CS",
                      },
                      ca: {
                        short: "CA",
                      },
                      trf: {
                        long: "Test Report Form",
                        short: "TRF",
                      }

                    }.freeze
Pubid::Iec::Identifier.set_config(config)
