Rails.application.routes.draw do
  resources :foods
  resources :analyses
  resources :children
  resources :meals
  resources :allergies
  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
