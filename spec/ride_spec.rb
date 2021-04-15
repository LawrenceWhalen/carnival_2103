require './lib/ride'

RSpec.describe 'Ride' do
  describe '#initialize' do
    it 'creates a ride' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride.class).to eq(Ride)
    end
    it 'has a name and a cost' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride.name).to eq('Ferris Wheel')
      expect(ride.cost).to eq(0)
    end
  end
end
