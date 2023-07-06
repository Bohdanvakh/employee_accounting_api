Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :departments, defaults: { format: :json }
      resources :employees, defaults: { format: :json }
      resources :positions, defaults: { format: :json }

      resources :employees do
        resources :position_histories, only: [:new, :create, :edit, :update], defaults: { format: :json }
        resources :vacations, only: [:new, :create], defaults: { format: :json }
      end
    end
  end
end
