Web::Application.routes.draw do
  devise_for :users

  resources :products

  root :to => "products#index"
end
