class User < ApplicationRecord
  has_many :operations, dependent: :destroy
  has_many :groups, dependent: :destroy
  
  validates :name, presence: true
end