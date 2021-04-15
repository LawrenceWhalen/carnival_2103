require './lib/carnival'
require '/lib/ride'
require '/lib/attendee'

RSpec.describe 'Carnival' do
  describe '#initialize' do
    it 'creates a carnival' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.class).to eq(Carnival)
    end
  end
end
