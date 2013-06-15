Lunchme::Application.routes.draw do

  root :to => 'application#index'

  resources :restaurants, :only => [:index]
  resources :lunches, :only => [:show]

end
