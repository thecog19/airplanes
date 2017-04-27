class Airplane < ApplicationRecord
  validates :priority, presence: true
  validates :size, presence: true
  validates :cargo_type, presence: true

  def self.enqueue(params)
    plane = Airplane.new(params)
    plane.priority = 0 
    return plane unless plane.valid?
    plane.priority = calculate_priority(params)
    plane.save
    plane
  end

  def self.calculate_priority(params)
    #the lower the number the sooner the plane is dequeued. 
    priority = 1
    priority += 2 if params["cargo_type"] == "cargo"
    priority += 1 if params["size"] == "small"
    priority
  end

  def self.dequeue
    return false if Airplane.all.empty?
    plane = Airplane.order(:priority, :updated_at).first
    plane.destroy
  end
end
 
