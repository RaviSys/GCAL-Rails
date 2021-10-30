Rails.application.routes.draw do
  resources :events do 
    patch :sync_event_with_google, on: :member
  end
  get 'calendar' => 'events#event_calendar'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'home#index'
end
