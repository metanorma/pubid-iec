require "parslet"
require "yaml"

module Pubid
  module Iec

  end

  module Core
    UPDATE_CODES = YAML.load_file(File.join(File.dirname(__FILE__), "../../update_codes.yaml"))
  end
end

require_relative "iec/parser"
require_relative "iec/amendment"
require_relative "iec/corrigendum"
require_relative "iec/renderer/pubid"
require_relative "iec/renderer/urn"
require_relative "iec/transformer"
require_relative "iec/identifier"
