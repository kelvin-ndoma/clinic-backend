Rails.application.routes.draw do
  # Create a patient
  post '/patients', to: 'patients#create'

  # Login (create a session)
  post '/login', to: 'sessions#create'

  # Stay in session (get the current user)
  get '/current_user', to: 'sessions#current_user'

  # Logout (destroy the session)
  delete '/logout', to: 'sessions#destroy'

  # Appointments routes
  resources :appointments, except: [:index, :show]

  # Services routes
  resources :services

  # For example, to show patient details and appointments:
  get '/patients/:id', to: 'patients#show'
  get '/patients/:id/appointments', to: 'patients#appointments'

  # Remaining routes...
end
