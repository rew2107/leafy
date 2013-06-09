Leafy::Application.routes.draw do
  authenticated :user do
    root :to => 'users#index'
  end

  root :to => "home#index"

  resources :users, :only => [:index, :show]
  resources :requests, :only => [:index, :show, :edit, :new]

  devise_for :users, :controllers => {:registrations => "registrations"}, :path => "userinfo"
end
