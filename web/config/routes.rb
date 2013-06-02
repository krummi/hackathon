Web::Application.routes.draw do
  resources :stores


  resources :receipt_items


  resources :receipts

  post "/receipt" => "receipts#from_text"  

  devise_for :users

  resources :products

  root :to => "products#index"
end
