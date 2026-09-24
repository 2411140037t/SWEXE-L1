Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # ↓ここに追記する(新しい draw do は書かない)
  resources :books
  root "books#index"

end