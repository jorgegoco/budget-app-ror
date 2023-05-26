class Operation < ApplicationRecord
  belongs_to :user
  has_one :group_operation, dependent: :destroy
  has_one :group, through: :group_operation

  validates :name, presence: true
  validates :amount, presence: true, numericality: true

end
