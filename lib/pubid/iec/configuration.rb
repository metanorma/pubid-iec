module Pubid::Iec
  class Configuration < Pubid::Core::Configuration
    def typed_project_stages
      types.inject({}) do |res, type|
        res.merge(type::PROJECT_STAGES)
      end
    end
  end
end
