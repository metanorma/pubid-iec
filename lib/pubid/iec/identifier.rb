module Pubid::Iec
  module Identifier
    class << self
      include Pubid::Core::Identifier

      def parse(*args)
        Base.parse(*args)
      end

      def build_project_stage(**args)
        TypedProjectStage.new(config: @config, **args)
      end
    end
  end
end
