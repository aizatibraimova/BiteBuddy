Rails.application.routes.draw do
  root "children#index"
  devise_for :users

  resources :children do
    resources :allergies
    resources :analyses
    resources :meals
  end

  resources :foods

  post "select_child", to: "children#select"
end
