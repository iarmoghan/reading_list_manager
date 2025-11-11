Rails.application.routes.draw do
  resources :books
  root "pages#home"
end

