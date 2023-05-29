require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  let(:user) { User.create(name: 'pepe', email: 'pepe@gmail.com', password: '123123') }
  let(:valid_attributes) { { name: 'Some', icon: 'some' } }
  let(:invalid_attributes) { { name: '', icon: 'some' } }

  before do
    sign_in user
  end

  describe 'GET /groups' do
    it 'renders a successful response' do
      get groups_url
      expect(response).to be_successful
      expect(response.body).to include('ADD NEW CATEGORY')
    end
  end

  describe 'GET /groups/new' do
    it 'renders a successful response' do
      get new_group_url
      expect(response).to be_successful
      expect(response.body).to include('Add image address')
    end
  end

  describe 'POST /groups' do
    context 'with valid parameters' do
      it 'creates a new Group' do
        expect do
          post groups_url, params: { group: valid_attributes }
        end.to change(Group, :count).by(1)
      end

      it "redirects to the Group's index" do
        post groups_url, params: { group: valid_attributes }
        expect(response).to redirect_to(groups_url)
        follow_redirect!
        expect(response.body).to include('Some')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Group' do
        expect do
          post groups_url, params: { group: invalid_attributes }
        end.to change(Group, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post groups_url, params: { group: invalid_attributes }
        expect(response).to be_successful
        expect(response.body).to include('Add image address')
      end
    end
  end

  describe 'DELETE /groups/:id' do
    it 'destroys the requested Group' do
      group = user.groups.create valid_attributes
      expect do
        delete group_url(group)
      end.to change(Group, :count).by(-1)
    end

    it "redirects to the Group's index" do
      group = user.groups.create valid_attributes
      delete group_url(group)
      expect(response).to redirect_to(groups_url)
      follow_redirect!
      expect(response.body).not_to include('Some')
    end
  end
end
