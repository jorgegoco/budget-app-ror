require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many operations' do
      user = User.reflect_on_association(:operations)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many groups' do
      user = User.reflect_on_association(:groups)
      expect(user.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with a name, email, and password' do
      user = User.new(
        name: 'Pepe',
        email: 'pepe@gmail.com',
        password: '123123'
      )
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(password: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid if the email is already taken' do
      User.create(
        name: 'Pepa',
        email: 'pepa@gmail.com',
        password: '123123'
      )
      user = User.new(
        name: 'Pepe',
        email: 'pepa@gmail.com',
        password: '456456'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid if the password is too short' do
      user = User.new(
        name: 'Pepe',
        email: 'pepe@gmail.com',
        password: '123'
      )
      expect(user).to_not be_valid
    end
  end
end