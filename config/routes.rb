Rails.application.routes.draw do

  resources :posts
  devise_for :users
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end


  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "pages#index"

  resources :days, :controller => 'days'
  resources :lectures, :controller => 'lectures'
  resources :speakers, :controller => 'speakers'

  resources :users, :controller => 'users'

  resources :calendars, :controller => 'calendars'
  resources :notifications, :controller => 'notifications'

  get "change_password", to: 'users#chg'
  patch "change_password", to: 'users#chgpsw'

  get "cp/indexcontent", to: 'frontpvs#edit_form'
  patch "cp/indexcontent", to: 'frontpvs#update_form'

  get "biography", to: 'pages#biography'
  patch "biography", to: 'pages#biography_update'

  get "unotifications", to: 'notifications#usernotifications'

  get "lecture", to: 'pages#lecture'
  get "schedule", to: 'pages#schedule'
  get "account", to: 'pages#account'
  get "calendar", to: 'pages#calendar'
  get "speaker", to: 'pages#speaker'
  get "speakers_list", to: 'pages#speakers'
  get "days_schedule", to: 'pages#days'

  get "admin", to: 'pages#admin'

  get "cp/cpHome", to: 'cp#cpHome'
  get "cp/days", to: 'days#days'
  get "cp/add_day", to: 'days#add_day'
  get "cp/edit_day", to: 'days#edit_day'
  get "cp/delete_day", to: 'days#delete_day'

  get "cp/add_lecture", to: 'lectures#add_lecture'
  get "cp/edit_lecture", to: 'lectures#edit_lecture'
  get "cp/lectures", to: 'lectures#lectures'

  get "cp/add_speaker", to: 'speakers#add_speaker'
  get "cp/edit_speaker", to: 'speakers#edit_speaker'
  get "cp/speakers", to: 'speakers#speakers'

  get "cp/notifications", to: 'notifications#index'
  get "cp/add_notification", to: 'notifications#new'

  get "cp/users", to: 'users#index'

  get "cp/register", to: 'users#new'

  # get "cp/users", to: 'cpusers#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase


end
