require './lib/attendee'

RSpec.describe 'Attendee' do
  describe '#initialize' do
    it 'creates and attendee' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.class).to eq(Attendee)
    end
    it 'has a name and an age' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.name).to eq('Bob')
      expect(attendee.spending_money).to eq(20)
    end
    it 'starts with no interests' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.interests).to eq([])
    end
  end
  describe '#add_interest' do
    it 'adds a ride name to the interests array' do
      attendee = Attendee.new('Bob', 20)

      attendee.add_interest('Bumper Cars')
      attendee.add_interest('Ferris Wheel')

      expect(attendee.interests).to eq(['Bumper Cars', 'Ferris Wheel'])
    end
  end
end
