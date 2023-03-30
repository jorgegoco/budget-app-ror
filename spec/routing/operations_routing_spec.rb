require 'rails_helper'

RSpec.describe OperationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/groups/1/operations').to route_to('operations#index', group_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/groups/1/operations/new').to route_to('operations#new', group_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/groups/1/operations').to route_to('operations#create', group_id: '1')
    end
  end
end