require 'rails_helper'

RSpec.describe 'groups/index', type: :view do
  let(:user) { User.create!(name: 'jorge', email: 'jorge@gmail.com', password: '123123') }

  before(:each) do
    assign(:groups, [
             Group.create!(
               name: 'Name1',
               icon: 'Icon1',
               user:
             ),
             Group.create!(
               name: 'Name2',
               icon: 'Icon2',
               user:
             )
           ])
  end

  it 'renders a list of groups' do
    render
    expect(response).to include('Name1')
    expect(response).to include('Name2')
  end

  it 'renders an img tag' do
    render
    expect(response).to have_selector('img')
  end

  it 'renders the title' do
    render
    expect(response).to have_content('Categories')
  end

  it 'renders the total amount spent' do
    render
    expect(response).to have_content('Total spent:')
  end
end
