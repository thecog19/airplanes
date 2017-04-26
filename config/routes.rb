Rails.application.routes.draw do
  root "boot#index"
  resources :airplanes, except: [:show, :edit, :update] 
end
