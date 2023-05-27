class Group < ApplicationRecord
  belongs_to :user
  has_many :operations, dependent: :destroy

  validates :name, :icon, presence: true

  def total_spent
    operations.map(&:amount).sum.round(2)
  end
end
