Imizuki::Application.routes.draw do
  resources :events
  resources :sessions, :only => [:new,:create,:destroy]

  match 'login' => 'sessions#new'
  match 'welcome' => "events#index"
  root :to => "events#index"
end
