require 'rails_helper'

RSpec.describe 'Operations', type: :request do
  let(:user) { User.create(name: 'pepe', email: 'pepe@gmail.com', password: '123123') }

  before do
    sign_in user
    @group = user.groups.create(name: 'Some', icon: 'some')
  end

  describe 'GET /groups/:group_id/operations' do
    it 'renders a successful response' do
      get group_operations_url(@group)
      expect(response).to be_successful
      expect(response.body).to include('ADD NEW OPERATION')
    end
  end

  describe 'GET /groups/:group_id/operations/new' do
    it 'renders a successful response' do
      get new_group_operation_url(@group)
      expect(response).to be_successful
      expect(response.body).to include('Amount')
    end
  end

  describe 'POST /groups/:group_id/operations' do
    context 'with valid parameters' do
      it 'creates a new Operation' do
        expect do
          post group_operations_url(@group), params: { operation: { name: 'Another', amount: 10 } }
        end.to change(Operation, :count).by(1)
      end

      it "redirects to the Group's Operations index" do
        post group_operations_url(@group), params: { operation: { name: 'Another', amount: 10 } }
        expect(response).to redirect_to(group_operations_url(@group))
        follow_redirect!
        expect(response.body).to include('Another')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Operation' do
        expect do
          post group_operations_url(@group), params: { operation: { name: '', amount: 10 } }
        end.to change(Operation, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post group_operations_url(@group), params: { operation: { name: '', amount: 10 } }
        expect(response).to be_successful
        expect(response.body).to include('Amount')
      end
    end
  end

  describe 'DELETE /groups/:group_id/operations/:id' do
    it 'destroys the requested Operation' do
      operation = @group.operations.create(name: 'Another', amount: 10, user_id: user.id, group_id: @group.id)
      expect do
        delete group_operation_url(@group, operation)
      end.to change(Operation, :count).by(-1)
    end

    it "redirects to the Group's Operations index" do
      operation = @group.operations.create(name: 'Another', amount: 10, user_id: user.id, group_id: @group.id)
      delete group_operation_url(@group, operation)
      expect(response).to redirect_to(group_operations_url(@group))
      follow_redirect!
      expect(response.body).not_to include('Another')
    end
  end
end
