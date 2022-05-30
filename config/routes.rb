Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :customer_transactions, path: :transactions, only: [:create, :index, :show]
      end
    end
  end
end
