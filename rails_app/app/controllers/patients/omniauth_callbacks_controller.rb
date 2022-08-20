# frozen_string_literal: true

class Patients::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # devise :omniauthable, omniauth_providers: [:google]

  # def google_oauth2
  #   @patient = Patient.find_create_for_google(request.env['omniauth.auth'])
  #   if @patient.persisted?
  #     sign_in_and_redirect @patient, event: :authentication
  #     set_flash_message(:notice, :success, kind: 'google') if is_navigational_format?
  #   else
  #     session['devise.google_data'] = request.env['omniauth.auth'][:info]
  #     redirect_to new_patient_registration_url
  #   end
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
