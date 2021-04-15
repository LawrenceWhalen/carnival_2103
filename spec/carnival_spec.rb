require './lib/carnival'
require './lib/ride'
require './lib/attendee'

RSpec.describe 'Carnival' do
  describe '#initialize' do
    it 'creates a carnival' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.class).to eq(Carnival)
    end
    it 'has a name and an empyt array for rides' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.name).to eq('Jefferson County Fair')
      expect(jeffco_fair.rides).to eq([])
    end
  end
  describe '#add_rides' do
    it 'adds ride instances to the ride array' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      expect(jeffco_fair.rides).to eq([ferris_wheel, bumper_cars, scrambler])
    end
  end
end
