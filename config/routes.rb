Imizuki::Application.routes.draw do
  resources :events

  match 'login' => 'sessions#new'
end
