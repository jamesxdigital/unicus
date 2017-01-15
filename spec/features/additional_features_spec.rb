require 'rails_helper'

describe 'managing additional features' do



specify 'I will receive a message as a manager when my employee updates a peer review' do
  employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
  manager_user = FactoryGirl.create(:user, id: 99, manager: 't', givenname: 'Chris', sn: 'smith', email: 'test2@sheffield.ac.uk')
  login_as(manager_user, :scope => :user)
  visit '/peer_reviews'
  click_link 'Create Peer Review'
  expect(page).to have_content 'New Peer Review'
  page.find('#peer_review_user_id').find(:xpath, 'option[1]').select_option
  page.find('#peer_review_deadline').set('2822-04-26 12:00 AM')
  click_button 'Update Peer Review'
  logout(:user)
  login_as(employee_user, :scope => :user)
  visit '/peer_reviews'
  click_link 'Edit'
  expect(page).to have_content 'Edit Peer Review'
  page.find('#peer_review_e_objective_response').set('its hard')
  page.find('#peer_review_e_overall_comments').set('trying')
  page.find('#peer_review_e_personal_development').set('so far so good')
  click_button 'Update Peer Review'
  logout(:user)
  login_as(manager_user, :scope => :user)
  visit '/messages'
  expect(page).to have_content 'Your employee, John smith, updated their Peer Review form! Please review it.'

end






  specify 'I will receive a message as an employee when my manager creates an objective for me' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', givenname: 'Chris', sn: 'smith', email: 'test2@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/settings'
    page.find('#objective_user_id').find(:xpath, 'option[1]').select_option
    page.find('#objective_title').set('Test Title')
    page.find('#objective_deadline').set('2016-04-26 12:00 AM')
    click_button 'Create'
    expect(page).to have_content 'Objective successfully added.'
    logout(:user)
    login_as(employee_user, :scope => :user)
    visit '/'
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content 'Chris smith assigned new objective!'
  end

  specify 'I will receive a message as a manager when my employee requests an objective for themselves' do
    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', givenname: 'Chris', sn: 'smith', email: 'test2@sheffield.ac.uk')
    login_as(employee_user, :scope => :user)
    visit '/objectives'
    click_link 'Create your own objective'
    expect(page).to have_content 'New objective'
    page.find('#objective_title').set('Test Title')
    page.find('#objective_description').set('Description')
    page.find('#objective_deadline').set('2016-04-26 12:00 AM')
    click_button 'Create'
    logout(:user)
    login_as(manager_user, :scope => :user)
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content 'John smith proposed new objective!'
    click_button 'Show'
    click_link 'Show Objective.'
    expect(page).to have_content 'Test Title'
    expect(page).to have_content 'Description'

  end

  specify 'I can approve proposed objective from my employee as manager' do

    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', givenname: 'Chris', sn: 'smith', email: 'test2@sheffield.ac.uk')
    login_as(employee_user, :scope => :user)
    visit '/objectives'
    click_link 'Create your own objective'
    expect(page).to have_content 'New objective'
    page.find('#objective_title').set('Test Title')
    page.find('#objective_description').set('Description')
    page.find('#objective_deadline').set('2016-04-26 12:00 AM')
    click_button 'Create'
    logout(:user)
    login_as(manager_user, :scope => :user)
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content 'John smith proposed new objective!'
    click_button 'Show'
    click_link 'Show Objective.'
    click_button 'Approve'
    expect(page).to have_content 'Confirm approval:'
    page.find('#message').set('I like it')
    click_button 'Approve'

  end

  specify 'I will receive a message as an employee when my manager approves my objective' do


    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', givenname: 'Chris', sn: 'smith', email: 'test2@sheffield.ac.uk')
    login_as(employee_user, :scope => :user)
    visit '/objectives'
    click_link 'Create your own objective'
    expect(page).to have_content 'New objective'
    page.find('#objective_title').set('Test Title')
    page.find('#objective_description').set('Description')
    page.find('#objective_deadline').set('2016-04-26 12:00 AM')
    click_button 'Create'
    logout(:user)
    login_as(manager_user, :scope => :user)
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content 'John smith proposed new objective!'
    click_button 'Show'
    click_link 'Show Objective.'
    click_button 'Approve'
    expect(page).to have_content 'Confirm approval:'
    page.find('#message').set('I like it')
    click_button 'Approve'
    logout(:user)
    login_as(employee_user, :scope => :user)
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content "Your objective 'Test Title' has been approved!"
    visit '/objectives'
    expect(page).to have_content 'Test Title'

  end

  specify 'I will receive a message as an employee when my manager rejects my objective' do


    employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
    manager_user = FactoryGirl.create(:user, id: 99, manager: 't', givenname: 'Chris', sn: 'smith', email: 'test2@sheffield.ac.uk')
    login_as(employee_user, :scope => :user)
    visit '/objectives'
    click_link 'Create your own objective'
    expect(page).to have_content 'New objective'
    page.find('#objective_title').set('Test Title')
    page.find('#objective_description').set('Description')
    page.find('#objective_deadline').set('2016-04-26 12:00 AM')
    click_button 'Create'
    logout(:user)
    login_as(manager_user, :scope => :user)
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content 'John smith proposed new objective!'
    click_button 'Show'
    click_link 'Show Objective.'
    click_button 'Reject'
    expect(page).to have_content 'Confirm rejection:'
    page.find('#message').set('I hate it')
    click_button 'Reject'
    logout(:user)
    login_as(employee_user, :scope => :user)
    page.has_css? ('#badge')
    visit '/messages'
    expect(page).to have_content "Your objective 'Test Title' have been rejected!"
    visit '/objectives'
    click_link 'Requested Objectives'
    expect(page).to have_content 'Test Title'

  end


  specify 'I can create create new training categories as an admin' do
    admin_user = FactoryGirl.create(:user, id: 99, manager: 't', admin: 't')
    login_as(admin_user, :scope => :user)
    visit '/settings'
    page.find('#training_category_category').set('Training1')
    click_button 'Create Training category'
    expect(page).to have_content "Training category was successfully created."
  end

  specify 'I can destroy existing training categories as an admin' do
    admin_user = FactoryGirl.create(:user, id: 99, manager: 't', admin: 't')
    login_as(admin_user, :scope => :user)
    visit '/settings'
    page.find('#training_category_category').set('Training1')
    click_button 'Create Training category'
    expect(page).to have_content "Training category was successfully created."
    visit '/settings'
    click_button 'Destroy'
    expect(page).to have_content "Training category was successfully destroyed."
  end

  specify 'I can add new company values as an admin' do
    admin_user = FactoryGirl.create(:user, manager_id: 99, admin: 't')
    login_as(admin_user, :scope => :user)
    visit '/company_values'
    expect(page).to have_content  "Company Values:"
    click_link 'New'
    expect(page).to have_content  "New Company Value"
    page.find('#company_value_company_value').set('Honesty')
    click_button 'Create Company value'
    expect(page).to have_content  "Company Values:"
    visit '/'
    within('div.col-md-6') {expect(page).to have_content 'Company Values'}
  end

  specify 'I can delete existing company values as an admin' do
    admin_user = FactoryGirl.create(:user, manager_id: 99, admin: 't')
    login_as(admin_user, :scope => :user)
    visit '/company_values'
    expect(page).to have_content  "Company Values:"
    click_link 'New'
    expect(page).to have_content  "New Company Value"
    page.find('#company_value_company_value').set('Honesty')
    click_button 'Create Company value'
    expect(page).to have_content  "Company Values:"
    visit '/'
    within('div.col-md-6') {expect(page).to have_content 'Company Values'}
    visit '/company_values'
    find('.btn-danger').click
    expect(page).to have_content  "Company Values:"

  end


end
