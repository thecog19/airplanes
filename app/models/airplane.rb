class Airplane < ApplicationRecord
  validates :priority, presence: true
  validates :size, presence: true
  validates :type, presence: true
end
