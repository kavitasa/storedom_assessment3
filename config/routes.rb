Rails.application.routes.draw do
  root 'items#index'

  resources :items,  only: [:index, :show, :update]
  patch '/activate_item/:id', to: 'items#activate', as: 'activate_item'
  resources :orders, only: [:index, :show]
  resources :users,  only: [:index, :show]
end
