Rails.application.routes.draw do
  resources :users do
    resources :albums, only: [:index, :destroy]
  end
  root to: 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
