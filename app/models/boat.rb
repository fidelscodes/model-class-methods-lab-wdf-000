class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end
  
  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    # all.each {|boat| boat if boat.classifications.include?("Sailboat")}
    joins(:classifications).where(classifications: {name: 'Sailboat'})
  end

  # to help with Captain tests
  def self.catamarans
    joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  # to help with Captain tests
  # def self.motorboats
  #   joins(:classifications).where(classifications: {name: 'Motorboat'})
  # end

  def self.with_three_classifications
    # joins(:boat_classifications)
    #   .group(:boat_id).count.collect do |boat_id, classifications|
    #   find(boat_id) if classifications == 3
    # end.compact
    joins(:boat_classifications).group(:boat_id).having("COUNT(*) = 3")
  end
end
