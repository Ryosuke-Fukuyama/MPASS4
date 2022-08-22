Rails.application.routes.draw do
  root 'tops#index'

  devise_for :patients, controllers: {
    sessions: 'patients/sessions',
    passwords: 'patients/passwords',
    registrations: 'patients/registrations',
    # omniauth_callbacks: 'patients/omniauth_callbacks'
  }
  resources :patients, only: %i[index show update destroy]

  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  resources :hospitals do
    collection do
      match 'search' => 'hospitals#search', via: [:get, :post], as: :search
    end
  end
  resources :hospital_labels, except: [:show]
end
