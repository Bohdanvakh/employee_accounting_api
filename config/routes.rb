Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :departments
      resources :employees
      resources :positions

      resources :employees do
        resources :position_histories, only: [:new, :create, :edit, :update], defaults: { format: :json }
        resources :vacations, only: [:new, :create], defaults: { format: :json }
      end
    end
  end
end
