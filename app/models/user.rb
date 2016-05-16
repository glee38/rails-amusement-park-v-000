class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, through: :rides

  def mood
    if self.happiness && self.nausea
      return "happy" if self.happiness >= self.nausea
      return "sad" if self.happiness < self.nausea
    end
  end

  def not_enough_tickets(attraction)
    self.tickets < attraction.tickets
  end

  def not_min_height(attraction)
    self.height < attraction.min_height
  end

  def too_short_and_no_money(attraction)
    not_min_height(attraction) && not_enough_tickets(attraction)
  end

  def update_details(attraction)
    update_tickets(attraction)
    update_happiness(attraction)
    update_nausea(attraction)
  end

  def update_tickets(attraction)
    tickets = self.tickets - attraction.tickets
    self.update_attribute(:tickets, tickets)
  end

  def update_happiness(attraction)
    happiness = self.happiness + attraction.happiness_rating
    self.update_attribute(:happiness, happiness)
  end

  def update_nausea(attraction)
    nausea = self.nausea + attraction.nausea_rating
    self.update_attribute(:nausea, nausea)
  end

end
