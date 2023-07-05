Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :departments
  resources :employees
  # resources :position_histories
  resources :positions

  resources :employees do
    resources :position_histories, only: [:new, :create, :edit, :update]
    resources :vacations, only: [:new, :create]
  end
end
