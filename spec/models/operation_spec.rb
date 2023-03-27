require 'rails_helper'

RSpec.describe Operation, type: :model do
  subject do
    user = User.create(name: 'Pepe')
    Operation.new(name: 'Dinner', amount: 242.2, user_id: user.id)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = ''
    expect(subject).not_to be_valid
  end

  it 'amount should be present and valid number' do
    subject.amount = 'a'
    expect(subject).not_to be_valid
  end
end
