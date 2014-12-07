Rails.application.routes.draw do
  root 'items#index'

  resources :items,  only: [:index, :show] do
    member do
      post 'activate'
    end
  end
  resources :orders, only: [:index, :show, :update]
  resources :users,  only: [:index, :show]
  resources :tests
end
