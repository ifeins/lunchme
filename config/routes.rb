Lunchme::Application.routes.draw do

  root :to => 'application#index'

  resources :restaurants, :only => [:index] do
    resources :tags, :only => [:create] do
      put :vote
    end
  end

  resources :lunches, :only => [:show] do
    resources :votes, :only => [:create, :destroy]
  end

  resource :session, :controller => :session, :only => [:destroy, :update]

  scope 'auth' do
    match ':provider' => 'session#does_not_matter', :as => :sign_in
    match ':provider/callback' => 'session#create'
    match 'failure' => 'session#failure'
  end

end
