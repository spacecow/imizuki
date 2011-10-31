Imizuki::Application.routes.draw do
  get "pictures/show"

  resources :pictures do
    collection do
      get 'last'
    end
  end
  resources :events
  resources :sessions, :only => [:new,:create,:destroy] do
    collection do
      get 'iphone'
    end
  end

  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#delete'
  match 'iphone' => 'sessions#iphone'
  match 'welcome' => "events#index"
  root :to => "events#index"
end
