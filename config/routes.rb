Rails.application.routes.draw do
  resources :departments
  resources :employees
  resources :position_histories
  resources :positions
end
