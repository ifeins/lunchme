Lunchme::Application.routes.draw do

  root :to => 'application#index'

  resources :restaurants, :only => [:index]
  resources :lunches, :only => [:show]

  match '/auth/:provider/callback' => 'session#create'
  match '/auth/failure' => 'session#failure'
  match '/auth/:provider' => 'session#does_not_matter', :as => 'sign_in'

end
