class Group < ApplicationRecord
  belongs_to :user
  has_many :group_operations, dependent: :destroy
  has_many :operations, through: :group_operations

  validates :name, :icon, presence: true

  def total_spent
    operations.map(&:amount).sum.round(2)
  end

  after_destroy :delete_associated_operations

  private

  def delete_associated_operations
    self.operations.each do |operation|
      operation.destroy
    end
  end
end
