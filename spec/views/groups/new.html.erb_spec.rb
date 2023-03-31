require 'rails_helper'

RSpec.describe 'groups/new', type: :view do
  before(:each) do
    assign(:group, Group.new(
                     name: 'NewCategory',
                     icon: 'NewIcon',
                     user: nil
                   ))
  end

  it 'renders new group form' do
    render
    expect(response).to include('NewCategory')
  end

  it 'renders an input tag' do
    render
    expect(response).to have_selector('input')
  end

  it 'renders the title' do
    render
    expect(response).to have_content('Add Category')
  end
end
