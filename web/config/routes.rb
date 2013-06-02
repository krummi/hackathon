Web::Application.routes.draw do
  resources :stores

  resources :receipt_items

  get "/my/receipts" => "receipts#index_mine"

  resources :receipts

  post "/receipt" => "receipts#from_text"  

  devise_for :users

  resources :products

  root :to => "products#index"
end
