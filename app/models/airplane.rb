class Airplane < ApplicationRecord
  validates :priority, presence: true
  validates :size, presence: true
  validates :cargo_type, presence: true
end
 