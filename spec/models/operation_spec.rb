require 'rails_helper'

RSpec.describe Operation, type: :model do
  let(:user) { User.create(name: "Pepe", email: "pepe@gmail.com", password: "123123") }
  let(:group) { Group.create(user: user, name: "Test Group", icon: "icon1") }

  context "validations" do
    it "is valid with a name and amount" do
      operation = group.operations.build(user: user, name: "Test Expense", amount: 10.5)
      expect(operation).to be_valid
    end

    it "is not valid without a name" do
      operation = group.operations.build(amount: 10.5)
      expect(operation).not_to be_valid
    end

    it "is not valid without an amount" do
      operation = group.operations.build(name: "Test Expense")
      expect(operation).not_to be_valid
    end

    it "is not valid with non-numeric amount" do
      operation = group.operations.build(name: "Test Expense", amount: "abc")
      expect(operation).not_to be_valid
    end
  end

  context "associations" do
    it "belongs to a user" do
      expect(Operation.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to a group" do
      expect(Operation.reflect_on_association(:group).macro).to eq(:belongs_to)
    end
  end
end