Leafy::Application.routes.draw do
  authenticated :user do
    root :to => 'users#index'
  end

  root :to => "home#index"

  resources :users, :only => [:index, :show]
  resources :messages, :only => [:create]
  resources :shoppings, :only => [:index, :show] do
    collection do
      get :search
      get :completed
      get :in_progress
    end
  end
  resources :request_baskets do
    collection do 
      get :active
      get :completed
      get :in_progress
    end
  end

  devise_for :users, :controllers => {:registrations => "registrations"}, :path => "userinfo"
end
