Rails.application.routes.draw do
  root 'tops#index'

  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions',
    # registrations: 'staffs/registrations'
  }
  devise_for :masters
  devise_for :patients, controllers: {
    sessions: 'patients/sessions',
    passwords: 'patients/passwords',
    registrations: 'patients/registrations'
    # omniauth_callbacks: 'patients/omniauth_callbacks'
  }

  resources :hospitals do
    collection do
      # match 'search' => 'hospitals#search', via: [:get, :post], as: :search
      # get 'maps'
    end
    member do
      resources :staffs, except: [:show]
      resources :health_interviews do
        collection do
          get 'reverse'
        end
      end
    end
  end
  resources :hospital_labels, except: [:show]
  resources :favorite_hospitals, only: %i[index create destroy]
  resources :patients, only: %i[index show destroy] # do
  #   post :pay, on: :member
  # end

  resources :tutorials, only: [:index] do
    collection do
      post 'guest_sign_in'
      post 'guest_staff_sign_in'
      post 'guest_admin_sign_in'
      post 'guest_master_sign_in'
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
