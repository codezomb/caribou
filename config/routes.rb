Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  scope(:api, defaults: { format: :json }) do
    resources :vehicles, only: [:show, :update]
  end

  root to: "vehicles#dashboard"
end
