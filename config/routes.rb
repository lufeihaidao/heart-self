HeartSelf::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match "custom" => "home#custom"
  devise_for :users
  resources :users
end
