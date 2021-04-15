require './lib/ride'

RSpec.describe 'Ride' do
  describe '#initialize' do
    it 'creates a ride' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride.class).to eq(Ride)
    end
  end
end
