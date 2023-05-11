module Pubid::Iec
  module WorkingDocument
    class << self
      include Pubid::Core::Identifier

      def parse(*args)
        Identifier::WorkingDocument.parse(*args)
      end
    end
  end
end
