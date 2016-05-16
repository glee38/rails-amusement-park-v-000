class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    @notice = nil
    if user.too_short_and_no_money(attraction)
      @notice = "Sorry. You do not have enough tickets the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif user.not_enough_tickets(attraction)
      @notice = "Sorry. You do not have enough tickets the #{attraction.name}."
    elsif user.not_min_height(attraction)
      @notice = "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      user.update_details(attraction)
      @notice = "Thanks for riding the #{attraction.name}!"
    end
    @notice
  end

end
