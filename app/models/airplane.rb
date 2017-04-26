class Airplane < ApplicationRecord
  validates :priority, presence: true
  validates :size, presence: true
  validates :cargo_type, presence: true

  def self.enqueue(params)
    p params
  end

end
 
