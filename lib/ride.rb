class Ride
  attr_reader :cost,
              :name
              
  def initialize(attributes)
    @name = attributes[:name]
    @cost = attributes[:cost]
  end
end
