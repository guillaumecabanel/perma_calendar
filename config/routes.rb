Rails.application.routes.draw do
  get 'advices/index'
  resources :advices, only: [:index]
end
