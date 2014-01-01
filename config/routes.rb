Lunchtime::Application.routes.draw do

  root :to => 'application#index'

  resources :restaurants, :only => [:index] do
    get :available_tags

    resources :tags, :only => [:create, :destroy] do
      put :vote
      put :unvote
    end
  end

  resources :lunches, :only => [:show] do
    collection do
      get :today
      get :yesterday
    end

    resources :votes, :only => [:create, :destroy]
    resources :visits, :only => [:create, :update]
    resources :surveys, :only => [:create]
  end

  resources :offices, :only => [:index, :create]

  resource :session, :controller => :session, :only => [:destroy, :update]

  scope 'auth' do
    match ':provider' => 'session#does_not_matter', :as => :sign_in
    match ':provider/callback' => 'session#create'
    match 'failure' => 'session#failure'
  end

end
