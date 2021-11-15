Rails.application.routes.draw do
  devise_for :users
  mount ApiRoot => ApiRoot::PREFIX
  mount GrapeSwaggerRails::Engine => '/apidoc'
  resources :courses
end
