require 'rails_helper'

describe 'Managing objectives' do

    specify 'I can set objectives for employees' do
      employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
      manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
      login_as(manager_user, :scope => :user)
      visit '/settings'
      page.find('#objective_user_id').find(:xpath, 'option[1]').select_option
      page.find('#objective_title').set('Test Title')
      page.find('#objective_deadline').set('2016-04-26 12:00 AM')
      click_button 'Create'
      expect(page).to have_content 'Objective successfully added.'
      logout(:user)
      login_as(employee_user, :scope => :user)
      visit '/objectives'
      within(:css, 'table') { expect(page).to have_content 'Test Title' }
    end

    specify 'I can see uncompleted objectives and the timeframe in which they must be completed' do
      employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
      manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
      login_as(employee_user, :scope => :user)
      visit '/objectives'
      page.should_not have_css('#clock1')
      logout(:user)
      login_as(manager_user, :scope => :user)
      visit '/settings'
      page.find('#objective_user_id').find(:xpath, 'option[1]').select_option
      page.find('#objective_title').set('Test Title')
      page.find('#objective_deadline').set('2816-04-26 12:00 AM')
      click_button 'Create'
      expect(page).to have_content 'Objective successfully added.'
      logout(:user)
      login_as(employee_user, :scope => :user)
      visit '/objectives'
      page.has_css?('#clock1')
    end


    specify 'See the performance of employees based on objectives they have met' do
      employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith', email: 'test1@sheffield.ac.uk')
      manager_user = FactoryGirl.create(:user, id: 99, manager: 't', email: 'test2@sheffield.ac.uk')
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
      #within(:css, 'progress') {expect(page).to have_content '0%'}
    end

    specify 'I can see completed objectives and the timeframe in when they were completed' do
      employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith')
      manager_user = FactoryGirl.create(:user, id: 99, manager: 't')
      login_as(employee_user, :scope => :user)
      visit '/objectives'
      page.has_css?('#clock1')
      page.has_css?('status_tag', :exact => true)
    end

    specify 'I can see the progress I have made and what still needs to be completed' do
      employee_user = FactoryGirl.create(:user, manager_id: 99, givenname: 'John', sn: 'smith')
      manager_user = FactoryGirl.create(:user, id: 99, manager: 't')
      login_as(employee_user, :scope => :user)
      visit '/'
      page.has_css?('Objectives Completion')
      page.has_css?('progress')
    end




end
