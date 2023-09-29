Rails.application.routes.draw do
  devise_for :users
  root to: "topics#index"
  resources :tags
  resources :topics do
    resources :posts do
      resources :comments
      resources :ratings
    end
  end
end
