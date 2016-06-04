Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy] do
    resources :posts, only: [:index]
  end

  resources :comments, only: [:create, :show]

  resources :posts, only: [:new, :show, :edit, :update, :destroy, :create] do
    resources :comments, only: [:new]
  end


end
