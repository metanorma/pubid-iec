require "parslet"
require "yaml"

module Pubid
  module Iec

  end
end

UPDATE_CODES = YAML.load_file(File.join(File.dirname(__FILE__), "../../update_codes.yaml"))

require_relative "iec/parser"
require_relative "iec/amendment"
require_relative "iec/corrigendum"
require_relative "iec/renderer"
require_relative "iec/transformer"
require_relative "iec/identifier"
