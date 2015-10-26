Rails.application.routes.draw do

  # root_to users_url
  resources :users do
    resources :subs, only: [:new]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: :new do
    resources :posts, only: [:new]
  end

  resources :posts, except: [:new]
  # except: :new do
  #   resources comments
  #
  # resources :posts, only: [:create, :destroy, :edit, :show, :update] do
  #   resources :c

end
