Leafy::Application.routes.draw do
  devise_for :users

  authenticated :user do
    root :to => 'users#index'
  end

  root :to => "home#index"

  resources :users, :only => [:index, :show]
  devise_for :users, :controllers => {:registrations => "registrations"}, :path => "userinfo"
end
