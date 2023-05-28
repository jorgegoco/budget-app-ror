require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create(name: 'pepe', email: 'pepe@gmail.com', password: '123123')
    @group = @user.groups.create(name: 'Some', icon: 'some')
    sign_in @user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get groups_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Some')
    end
  end

# RSpec.describe GroupsController, type: :request do
#   let(:user) { User.create(name: 'Pepe', email: 'pepe@gmail.com', password: '123123') }

#   describe 'GET #index' do
#     it 'returns a success response' do
#       Group.create!(name: 'Test Group', icon: 'icon', user: user)
#       get groups_url
#       # puts response.body
#       # expect(response.body).to include('Test Group')
#       expect(response).to have_http_status(:ok)
#       expect(response).to render_template('index')
#     end
#   end

  # describe 'GET /new' do
  #   it 'renders a successful response' do
  #     get new_group_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Group' do
  #       expect do
  #         Group.create! valid_attributes
  #       end.to change(Group, :count).by(1)
  #     end
  #   end
  # end
end
