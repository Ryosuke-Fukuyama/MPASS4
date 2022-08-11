Rails.application.routes.draw do
  root 'tops#index'

  devise_for :patients, controllers: {
    sessions: 'patients/sessions',
    passwords: 'patients/passwords',
    registrations: 'patients/registrations',
    # omniauth_callbacks: 'patients/omniauth_callbacks'
  }
end
