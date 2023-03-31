require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Pepe') }

  before { subject.save }

  it 'name should be present' do
    subject.name = ''
    expect(subject).not_to be_valid
  end
end
