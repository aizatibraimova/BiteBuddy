Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'landing_page#index', as: :authenticated_root 
  end

  unauthenticated do
    root 'landing_page#index', as: :unauthenticated_root
  end

  resources :children do
    member do
      get "details", to: "children#details", as: :details
    end
    resources :allergies
    resources :analyses do
      collection do
        post "fetch_meals_and_allergies"
      end
    end
    resources :meals
  end

  resources :foods

  post "select_child", to: "children#select", as: 'select_child'
end
