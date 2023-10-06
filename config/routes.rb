Rails.application.routes.draw do
  devise_for :users
  root to: "topics#index"
  resources :tags
  resources :topics do
    resources :posts do
      patch '/mark_post_as_read',on: :member, to: 'posts#mark_as_read'
      resources :comments
      resources :ratings
    end
  end
end
