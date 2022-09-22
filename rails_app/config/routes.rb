Rails.application.routes.draw do
  get 'staffs/index'
  get 'staffs/new'
  get 'staffs/create'
  get 'staffs/edit'
  get 'staffs/update'
  get 'staffs/destroy'
  get 'staffs/_form'
  root 'tops#index'

  resources :patients, only: %i[index show destroy]
  devise_for :patients, controllers: {
    sessions: 'patients/sessions',
    passwords: 'patients/passwords',
    registrations: 'patients/registrations',
    # omniauth_callbacks: 'patients/omniauth_callbacks'
  }

  resources :hospitals do
    collection do
      match 'search' => 'hospitals#search', via: [:get, :post], as: :search
    end
    resources :staffs, except: [:show]
  end
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions',
    # registrations: 'staffs/registrations'
  }

  resources :hospital_labels, except: [:show]
  resources :favorite_hospitals, only: %i[index create destroy]
end
