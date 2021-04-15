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
    it 'starts without any attendees' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.attendees).to eq([])
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
  describe '#recommend_rides' do
    it "returns an array of ride instances that match an attendees interests" do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Scrambler')

      expect(jeffco_fair.recommend_rides(bob)).to eq([ferris_wheel, bumper_cars])
      expect(jeffco_fair.recommend_rides(sally)).to eq([scrambler])
    end
  end
  describe '#admit' do
    it 'adds an attendee instance to the attendee array' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Scrambler')
      johnny.add_interest('Bumper Cars')

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      expect(jeffco_fair.attendees).to eq([bob, sally, johnny])
    end
  end
  describe '#attendees_by_ride_interest' do
    it 'returns a hash of rides keying the attendees interested in them' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      johnny.add_interest('Bumper Cars')

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      expected = {
                  ferris_wheel => [bob],
                  bumper_cars => [bob, sally, johnny],
                  scrambler => []
      }

      expect(jeffco_fair.attendees_by_ride_interest).to eq(expected)
    end
  end
  describe '#ticket_lottery_contestants' do
    it 'returns an array of all the attendees interested in a ride that can not afford it' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      johnny.add_interest('Bumper Cars')

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      expect(jeffco_fair.ticket_lottery_contestants(bumper_cars)).to eq([bob, johnny])
    end
  end
  describe '#draw_lottery_winner' do
    it 'returns one eligable lotter contestent for that ride' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      johnny.add_interest('Bumper Cars')

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      expect(jeffco_fair.draw_lottery_winner(bumper_cars)).to eq('Johnny')
                                                          .or eq('Bob')
    end
    it 'returns nil if no one is eligable' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      johnny.add_interest('Bumper Cars')

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      expect(jeffco_fair.draw_lottery_winner(ferris_wheel)).to eq(nil)
    end
  end
  describe '#announce_lottery_winner' do
    it 'announces the winner and what they have won' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      johnny.add_interest('Bumper Cars')

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      allow(jeffco_fair).to receive(:draw_lottery_winner) { 'Bob'}

      expect(jeffco_fair.announce_lottery_winner(scrambler)).to eq('Bob has won the Scrambler')
    end
  end
end
