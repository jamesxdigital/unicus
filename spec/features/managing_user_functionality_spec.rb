require 'rails_helper'

describe 'Managing user functionality' do

  specify 'I can login with own CICS username and password' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    expect(page).to have_content 'Dashboard'
  end

  specify 'I can request training' do
    manager_and_admin_user = FactoryGirl.create(:user, id: 99, manager: 't', admin: 't')
    employee_user = FactoryGirl.create(:user, manager_id: 99, manager: 'f')
    login_as(manager_and_admin_user, :scope => :user)
    visit '/settings'
    page.find('#training_category_category').set('Training1')
    click_button 'Create Training category'
    expect(page).to have_content "Training category was successfully created."
    login_as(employee_user, :scope => :user)
    visit '/'
    page.find('#request_comments').set('category is suitable')
    click_button 'submit'
    expect(page).to have_content  "Training category was successfully created."
  end

  specify 'I can see the training requested by employees' do
    manager_and_admin_user = FactoryGirl.create(:user, id: 99, manager: 't', admin: 't')
    employee_user = FactoryGirl.create(:user, manager_id: 99, manager: 'f')
    login_as(manager_and_admin_user, :scope => :user)
    visit '/settings'
    page.find('#training_category_category').set('Training1')
    click_button 'Create Training category'
    expect(page).to have_content "Training category was successfully created."
    login_as(employee_user, :scope => :user)
    visit '/'

    click_button 'submit'
    expect(page).to have_content  "Training category was successfully created."
    logout(:user)
    login_as(manager_and_admin_user, :scope => :user)
    visit '/'
    page.has_css?('#canvas')
  end

  specify 'I can see company values' do
    admin_user = FactoryGirl.create(:user, manager_id: 99, admin: 't')
    user = FactoryGirl.create(:user, manager_id: 99)
    login_as(admin_user, :scope => :user)
    visit '/company_values'
    expect(page).to have_content  "Company Values:"
    click_link 'New'
    expect(page).to have_content  "New Company Value"
    page.find('#company_value_company_value').set('Honesty')
    click_button 'Create Company value'
    expect(page).to have_content  "Company Values:"
    logout(:user)
    login_as(user, :scope => :user)
    visit '/'
    within('div.col-md-6') {expect(page).to have_content 'Company Values'}
  end

  specify 'I can edit individual users within the system' do
    admin_user = FactoryGirl.create(:user, admin: 't', manager: 't', id: 100)
    user1 = FactoryGirl.create(:user, id: 99, admin: 't', manager: 't')
    login_as(admin_user, :scope => :user)
    visit '/admin/users'
    expect(page).to have_content  "Listing users:"
    within(:css, 'table') { expect(page).to have_content 'true' }
    click_link 'Edit'
    expect(page).to have_content  "Assign employee manager"
    page.find('#user_admin').set(false)
    click_button 'Update User'
    expect(page).to have_content 'Your details were successfully updated'
    within(:css, 'table') { expect(page).to have_content 'false' }
  end

  specify 'I can delete individual users within the system' do

    admin_user = FactoryGirl.create(:user, admin: 't', manager: 't', id: 100)
    user1 = FactoryGirl.create(:user, id: 99)
    login_as(admin_user, :scope => :user)
    visit '/admin/users'
    expect(page).to have_content  "Listing users:"
    within(:css, 'table') { expect(page).to have_content '99' }
    #find(:xpath, "//tr[td[contains(.,'99')]]/td/a", :text => 'manage').click

    find('#deleteModal99').click
    page.should have_content('Are you sure?')
    click_link 'Yes, delete this user'
    #page.find('#delete_button').click
    #page.find('#delete_confirm').click
    within(:css, 'table') { expect(page).to_not have_content '99' }
  end

  specify 'I can export the user data in csv' do

    admin_user = FactoryGirl.create(:user, admin: 't', manager: 't', id: 100)
    user1 = FactoryGirl.create(:user, id: 99)
    login_as(admin_user, :scope => :user)
    visit '/admin/users'
    expect(page).to have_content  "Listing users:"
    within(:css, 'table') { expect(page).to have_content '99' }
    #find(:xpath, "//tr[td[contains(.,'99')]]/td/a", :text => 'manage').click

    find('#myModal').click
    page.should have_content('Export User Data')
    click_link 'Download'

    #page.find('#delete_button').click
    #page.find('#delete_confirm').click

  end

  specify 'I can export the training request in csv' do

    admin_user = FactoryGirl.create(:user, admin: 't', manager: 't', id: 100)
    user1 = FactoryGirl.create(:user, id: 99)
    login_as(admin_user, :scope => :user)
    visit '/'
    expect(page).to have_content  "Training Requests Statistics"
    click_link 'More info'
    #find(:xpath, "//tr[td[contains(.,'99')]]/td/a", :text => 'manage').click
    visit '/requests'
    find('#myModal').click
    page.should have_content('Export Training Request')
    click_link 'Download'

    #page.find('#delete_button').click
    #page.find('#delete_confirm').click

  end

  specify 'I can export the performance data in csv' do

    manager_user = FactoryGirl.create(:user, admin: 'f', manager: 't', id: 99, email: 'test@sheffield.ac.uk')
    employee_user = FactoryGirl.create(:user, manager_id: 99, manager: 'f', email: 'test1@sheffield.ac.uk')
    login_as(manager_user, :scope => :user)
    visit '/settings'
    page.find('#objective_user_id').find(:xpath, 'option[1]').select_option
    page.find('#objective_title').set('Test Title')
    page.find('#objective_deadline').set('2016-04-26 12:00 AM')
    click_button 'Create'
    expect(page).to have_content 'Objective successfully added.'
    visit '/performance_review'
    expect(page).to have_content  "Performance Review"
    find('#myModal').click
    page.should have_content('Export Performance Data')
    click_link 'Download'


  end




end
