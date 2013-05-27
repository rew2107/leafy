Leafy::Application.routes.draw do
  devise_for :users

  authenticated :user do
    root :to => 'home#index'
  end

  devise_scope :user do
    root :to => "devise/registrations#new"
  end
end
