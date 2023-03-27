class Group < ApplicationRecord
  belongs_to :user
  has_many :group_operations, dependent: :delete_all
  has_many :operations, through: :group_operations
  
  validates :name, :icon, presence: true
end