Rails.application.routes.draw do

  resources :training_categories
  mount EpiCas::Engine, at: "/"
  devise_for :users
  resources :reviews
  scope "/admin" do
   resources :users
  end
    #match 'users/index', to: 'users#index', via: 'get'
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "pages#home"

  get '/calendar' => 'pages#calendar'

  #get '/peer_reviews' => 'peer_reviews#index'

  get '/settings' => 'settings#index'

  get '/performance_review' => 'performance_review#index'

  #get '/company_values' => 'company_values#index'

  resources :mailer_settings
  resources :messages

  resources :objectives do
    get :unapproved, on: :collection
    get :approve_confirm, on: :member
    patch :approve, on: :member
    get :reject_confirm, on: :member
    patch :reject, on: :member
    get :show_unapproved, on: :member
    get :requested, on: :collection
    get :show_rejected, on: :member
  end


  resources :peer_reviews do
    get :show_photo, on: :member
  end

  resources :requests do
    get :destroy_all, on: :collection
  end

  resources :company_values

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
