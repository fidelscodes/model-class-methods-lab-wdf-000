class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    # Boat.joins(:classifications).where(classifications: {name: "Catamaran"}).map(&:captain)
    #
    # Boat.catamarans.pluck(&:captain) # only returns array with captain info, not the actual objects
    
    # Return an Array of captain objects
    # captains = Boat.joins(:classifications).where(classifications: {name: 'Catamaran'}).map(&:captain)
    # Convert captains from Array to ActiveRecord_Relation
    # self.where(id: captains.map(&:id))
    
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    # captains_with_sailboats = Boat.sailboats.where('captain_id').map(&:captain)
    # self.where(id: captains_with_sailboats.map(&:id))
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seamen
    t_s = sailors & motorboat_operators
    where(id: t_s.map(&:id))
  end

  def self.non_sailors
    sailor_ids = Captain.sailors.map(&:id)
    where.not(id: sailor_ids)
  end
end
