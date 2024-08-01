Rails.application.routes.draw do
  root "children#index"
  devise_for :users

  resources :children do
    member do
      get "details"
    end
    resources :allergies
    resources :analyses do
      collection do
        get "fetch_meals_and_allergies"
      end
    end
    resources :meals
  end

  resources :foods

  post "select_child", to: "children#select"
end
