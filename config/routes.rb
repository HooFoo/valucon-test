Rails.application.routes.draw do
  resources :users

  root 'index#index'
  get 'index/index'
  get  '/signup',  to: 'users#new'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
