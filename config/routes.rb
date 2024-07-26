Rails.application.routes.draw do
  root "children#new"
  devise_for :users
  resources :foods
  
  resources :children do
    resources :allergies
    resources :analyses
    resources :meals
  end

  post "select_child", to: "children#select"
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
end
