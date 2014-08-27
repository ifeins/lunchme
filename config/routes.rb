Rails.application.routes.draw do

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
    end

    resources :votes, :only => [:create, :destroy]
    resources :visits, :only => [:create, :update]
  end

  resources :offices, :only => [:index, :create]

  resource :session, :controller => :session, :only => [:destroy, :update]

  scope 'auth' do
    get ':provider' => 'session#does_not_matter', :as => :sign_in
    get ':provider/callback' => 'session#create'
    get 'failure' => 'session#failure'
  end

  scope 'status', :controller => :status do
    get 'ping'
  end

end
