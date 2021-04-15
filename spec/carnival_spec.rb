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
      expect(jeffco_fair.ride).to eq([])
    end
  end
end
