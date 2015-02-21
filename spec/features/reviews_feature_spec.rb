require 'rails_helper'

feature 'reviewing' do 
  before{Restaurant.create name: 'KFC'}

  def leave_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'allows users to leave a review using a form' do 
    leave_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end 

  scenario 'all reviews are deleted when reviewed restaurant is deleted' do
    leave_review
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(current_path).to eq '/restaurants'
    expect(page).not_to have_content('so so')
  end

end