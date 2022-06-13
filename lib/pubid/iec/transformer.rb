module Pubid::Iec
  class Transformer < Parslet::Transform
    rule(database: "DB") do
      { database: true }
    end
  end
end
