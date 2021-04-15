require './lib/attendee'

RSpec.describe 'Attendee' do
  describe '#initialize' do
    it 'creates and attendee' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.class).to eq(Attendee)
    end
  end
end
