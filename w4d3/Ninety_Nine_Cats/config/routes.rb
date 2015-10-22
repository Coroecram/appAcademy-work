NinetyNineCats::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  resources :cats
  resources :cat_rental_requests
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

end
