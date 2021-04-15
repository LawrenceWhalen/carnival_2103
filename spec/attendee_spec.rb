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
      expect(attendee.age).to eq(20)
    end
  end
end
