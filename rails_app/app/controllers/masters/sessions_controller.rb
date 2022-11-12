# frozen_string_literal: true

class Masters::SessionsController < Devise::SessionsController
  # include Recaptcha
  prepend_before_action :check_captcha_sign_in, only: [:create]
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  # def after_sign_in_path_for(resource)
  #   master_path(resource)
  # end

  private

  def check_captcha_sign_in
    unless verify_recaptcha(message: t('message.verification_failed'))
      self.resource = resource_class.new sign_in_params
      resource.validate
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end
end
