require 'rails_helper'

RSpec.describe '/operations', type: :request do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  let(:group) { Group.create(user:, name: 'Shopping', icon: 'icon_here') }

  let(:valid_attributes) do
    { user:, name: 'Food', amount: 22 }
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_operation_url(group)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Operation' do
        expect do
          Operation.create! valid_attributes
        end.to change(Operation, :count).by(1)
      end
    end
  end
end
