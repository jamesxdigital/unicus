require 'rails_helper'

describe 'Managing peer reviews' do

  specify 'I can create peer reviews for employees' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Create Peer Review'
    page.find('#peer_review_user_id').find(:xpath, 'option[1]').select_option
    page.find('#peer_review_deadline').set('2816-04-26 12:00 AM')
    click_button 'Update Peer Review'
    expect(page).to have_content 'Peer Review successfully updated'
    logout(:user)
    login_as(employee_user, :scope => :user)
    visit '/peer_reviews'
    within(:css, 'table') { expect(page).to have_content '2816-04-26' }
  end

  specify 'I can view previous peer review forms' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Create Peer Review'
    page.find('#peer_review_user_id').find(:xpath, 'option[1]').select_option
    page.find('#peer_review_deadline').set('2015-04-26 12:00 AM')
    click_button 'Update Peer Review'
    expect(page).to have_content 'Peer Review successfully updated'
    logout(:user)
    login_as(employee_user, :scope => :user)
    visit '/peer_reviews'
    within(:css, 'table') { expect(page).to have_content '2015-04-26' }
  end

  specify 'I can submit a peer review form' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Create Peer Review'
    page.find('#peer_review_user_id').find(:xpath, 'option[1]').select_option
    page.find('#peer_review_deadline').set('2816-04-26 12:00 AM')
    click_button 'Update Peer Review'
    logout(:user)
    login_as(employee_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Edit'
    page.find('#peer_review_e_objective_response').set('This is my response to the peer review objective')
    page.find('#peer_review_e_overall_comments').set('This is my response to the peer review overall comments')
    page.find('#peer_review_e_personal_development').set('This is my response to the peer review personal development')
    click_button 'Update Peer Review'
    expect(page).to have_content 'Peer Review successfully updated'
    expect(page).to have_content 'This is my response to the peer review objective'
    expect(page).to have_content 'This is my response to the peer review overall comments'
    expect(page).to have_content 'This is my response to the peer review personal development'
    logout(:user)
    login_as(manager_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Edit'
    page.find('#peer_review_m_objective_response').set('This is my response to the employee objectives')
    page.find('#peer_review_m_overall_comments').set('This is my response to the employee comments')
    page.find('#peer_review_m_personal_development').set('This is my response to the employee development')
    click_button 'Update Peer Review'
    expect(page).to have_content 'Peer Review successfully updated'
    expect(page).to have_content 'This is my response to the employee objectives'
    expect(page).to have_content 'his is my response to the employee comments'
    expect(page).to have_content 'This is my response to the employee development'
  end

  specify 'I can see how long I have to complete the current peer review' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Create Peer Review'
    page.find('#peer_review_user_id').find(:xpath, 'option[1]').select_option
    page.find('#peer_review_deadline').set('2816-04-26 12:00 AM')
    click_button 'Update Peer Review'
    logout(:user)
    login_as(employee_user, :scope => :user)
    visit '/peer_reviews'
    page.has_css?('#clock1')
  end

  specify 'I can upload evidence of completing objectives' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test2@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Create Peer Review'
    page.find('#peer_review_user_id').find(:xpath, 'option[1]').select_option
    page.find('#peer_review_deadline').set('2816-04-26 12:00 AM')
    click_button 'Update Peer Review'
    logout(:user)
    login_as(employee_user, :scope => :user)
    visit '/peer_reviews'
    click_link 'Edit'
    attach_file('peer_review_photo', File.absolute_path(Rails.root+'public/index.jpg'))
    click_button 'Update Peer Review'
    page.has_css?('#Show photo')
end

end
