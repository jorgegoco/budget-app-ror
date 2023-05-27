require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: "Pepe", email: "pepe@gmail.com", password: "123123") }
  let(:group) { user.groups.build(name: "Test Group", icon: "test-icon") }

  context "validations" do
    it "is valid with a name and icon" do
      expect(group).to be_valid
    end

    it "is not valid without a name" do
      group.name = nil
      expect(group).not_to be_valid
    end

    it "is not valid without an icon" do
      group.icon = nil
      expect(group).not_to be_valid
    end
  end

  context "associations" do
    it "belongs to a user" do
      expect(Group.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "has many operations" do
      expect(Group.reflect_on_association(:operations).macro).to eq(:has_many)
    end

    it "destroys its associated operations upon deletion" do
      group.save!
      operation = group.operations.create!(user: user, name: "Test Operation", amount: 10.0)
      expect { group.destroy }.to change { Operation.count }.by(-1)
    end
  end

  describe "#total_spent" do
    let(:group) { user.groups.create(name: "Test Group", icon: "test-icon") }
    let!(:operation1) { group.operations.create(name: "Test Expense 1", amount: 10.5) }
    let!(:operation2) { group.operations.create(name: "Test Expense 2", amount: 25.0) }

    it "returns the sum of all operation amounts as a float rounded to two decimal places" do
      expect(group.total_spent).to eq(35.5)
    end
  end
end