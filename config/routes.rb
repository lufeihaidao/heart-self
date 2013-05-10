HeartSelf::Application.routes.draw do
  #authenticated :user do
    #root :to => 'home#index'
  #end
  root :to => "home#index"
  match "/custom" => "home#custom", :as => "custom"
  match "/taobao" => "home#taobao", :as => "taobao"
  match "/display" => "home#display", :as => "display"
  match "/quality" => "home#quality", :as => "quality"
  match "/myproductions" => "home#myproductions", :as => "myproductions"
  devise_for :users
  resources :users
  resources :productions
  resources :user_productions, :only => [:edit, :update]
end
