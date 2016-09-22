class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    max_length = Boat.maximum(:length)
    classification_ids = Boat.where(length: max_length).first.classifications.map(&:id)
    where(id: classification_ids)
  end
end
