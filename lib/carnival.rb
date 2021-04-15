class Carnival
  attr_reader :name,
              :rides,
              :attendees

  def initialize(name)
    @name = name
    @rides = []
    @attendees = []
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def recommend_rides(attendee)
    @rides.find_all do |ride|
      attendee.interests.include?(ride.name)
    end
  end

  def admit(attendee)
    @attendees.push(attendee)
  end

  def attendees_by_ride_interest
    @rides.each_with_object({}) do |ride, hash|
      hash[ride] = @attendees.find_all do |attendee|
        attendee.interests.include?(ride.name)
      end
    end
  end

  def ticket_lottery_contestants(ride)
    interested_attendees = attendees_by_ride_interest[ride]
    interested_attendees.find_all do |attendee|
      attendee.spending_money < ride.cost
    end
  end

  def draw_lottery_winner(ride)
    contestents = ticket_lottery_contestants(ride)
    if contestents == []
      nil
    else
      winner = contestents.sample
      winner.name
    end
  end
end
