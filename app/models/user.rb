class User < ApplicationRecord
  has_many :operations, dependent: :destroy
  has_many :groups, dependent: :destroy
  
  validates :name, presence: true, length: { in: 1..50 }
end