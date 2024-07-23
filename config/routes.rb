Rails.application.routes.draw do
  resources :analyses
  resources :food_logs
  resources :allergies
  resources :foods
  resources :children

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
