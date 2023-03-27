class Operation < ApplicationRecord
  belongs_to :user
  has_many :group_operations, dependent: :delete_all
  has_many :groups, through: :group_operations

  validates :name, :amount, presence: true, length: { in: 1..50 }
end