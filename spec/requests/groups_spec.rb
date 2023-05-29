require 'rails_helper'

RSpec.describe 'Groups', type: :request do

  let(:user) { User.create(name: 'pepe', email: 'pepe@gmail.com', password: '123123') }
  let(:valid_attributes) { { name: 'Some', icon: 'some' } }
  let(:invalid_attributes) { { name: '' } }


  before do
    sign_in user
  end

  describe 'GET /index' do
    it "renders a successful response" do
      group = user.groups.create valid_attributes
      get groups_url
      expect(response).to be_successful
      expect(response.body).to include(group.name)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Group" do
        expect {
          post groups_url, params: { group: valid_attributes }
        }.to change(Group, :count).by(1)
      end

      it "redirects to the group's index" do
        post groups_url, params: { group: valid_attributes }
        expect(response).to redirect_to(groups_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Group" do
        expect {
          post groups_url, params: { group: invalid_attributes }
        }.to change(Group, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post groups_url, params: { group: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested Group" do
      group = user.groups.create valid_attributes
      expect {
        delete group_url(group)
      }.to change(Group, :count).by(-1)
    end

    it "redirects to the group's index" do
      group = user.groups.create valid_attributes
      delete group_url(group)
      expect(response).to redirect_to(groups_url)
    end
  end
end
