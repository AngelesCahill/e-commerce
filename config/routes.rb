Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :users
  root "homes#index"
    #resources :homes
    #resources :categories
    #resources :products
  authenticate :admin do
    resources :products
    resources :categories
  end

  authenticate :user do
    resources :products, only: [:index]
  end

  resource :cart, only: [:show, :update] do
    member do
      post :pay_with_paypal
      get :process_paypal_payment
    end
  end



  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
end
