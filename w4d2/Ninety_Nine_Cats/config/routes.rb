NinetyNineCats::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  resources :cats
  resources :cat_rental_requests
end
