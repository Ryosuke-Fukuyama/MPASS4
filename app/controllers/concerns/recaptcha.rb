module Recaptcha

  extend ActiveSupport::Concern

  private

  def check_captcha_sign_up
    unless verify_recaptcha(message: t('message.verification_failed'))
      self.resource = resource_class.new sign_up_params
      resource.validate
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end

  def check_captcha_sign_in
    unless verify_recaptcha(message: t('message.verification_failed'))
      self.resource = resource_class.new sign_in_params
      resource.validate
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end
end