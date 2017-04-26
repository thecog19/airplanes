class Airplane < ApplicationRecord
  validates :priority, presence: true
  validates :size, presence: true
  validates :cargo_type, presence: true

  def self.enqueue(params)
    plane = Airplane.new(params)
    plane.priority = 0 
    return plane.errors unless plane.valid?
    plane.priority = calculate_priority(params)
    plane.save
    plane
  end

  def self.calculate_priority(params)
    #the lower the number the sooner the plane is dequeued. 
    4
  end
end
 
