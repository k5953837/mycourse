Rails.application.routes.draw do
  devise_for :users
  mount ApiRoot => ApiRoot::PREFIX
  resources :courses
end
