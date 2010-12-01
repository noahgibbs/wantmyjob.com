Wantmyjob::Application.routes.draw do
  resources :companies

  resources :answers do
    collection do
      post :match_all_profiles
    end
  end

  resources :work_sites do
    member do
      post :companify
    end
  end

  resources :jobs do
    collection do
      get :enter
      post :enter_post
    end
  end

  resources :statistics

  resources :profiles do
    collection do
      get :me
      post :clear_matches
      get :show_matches
      post :recalculate_matches
    end
  end

  resources :question_answers

  resources :questions do
    collection do
      get :answer
      post :answer_post
      get :enter
      post :enter_post
      post :verify_questions
    end
  end

  resources :matches, :only => [:show]

  devise_for :users, :controllers => {:registrations => "registrations"}

  # Landing page on login
  match '/home/portal' => 'home#portal', :as => 'user_root'

  # Random one-off matches
  match '/about' => 'home#about'
  match '/privacy' => 'home#privacy'

  scope '/statsfeed' do
    resources :notes, :actions => [:index]
  end

  # Admin tools
  match '/admin/console' => 'admin#console'
  match '/admin/become_user' => 'admin#become_user', :via => :post

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"
end
