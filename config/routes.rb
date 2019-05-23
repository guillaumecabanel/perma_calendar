Rails.application.routes.draw do
  root to: 'advices#index'
  resources :advices, only: [:index]
end
