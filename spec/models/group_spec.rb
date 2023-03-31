require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    user = User.create(name: 'Pepe')
    Group.new(name: 'App', icon: 'some', user_id: user.id)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = ''
    expect(subject).not_to be_valid
  end

  it 'icon should be present' do
    subject.icon = ''
    expect(subject).not_to be_valid
  end
end
