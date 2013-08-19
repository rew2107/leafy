Leafy::Application.routes.draw do
  authenticated :user do
    root :to => 'users#index'
  end

  root :to => "home#index"

  resources :users, :only => [:index, :show]
  resources :messages, :only => [:create, :index, :show]
  resources :bids, :only => [:create]
  resources :shopper_applications, :only => [:index, :create]
  resources :request_baskets do
    collection do 
      get :search
      get :active
      get :completed
    end
  end

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :confirmations => 'confirmations',
  }, :path => "userinfo"

  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end
end
