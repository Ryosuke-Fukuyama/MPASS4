module PasswordValidates
  extend ActiveSupport::Concern

  included do
    validates :password, on: :create,
                         presence: true,
                         confirmation: true,
                         format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)(?=.*?[!-\/:-@\[-`{-~])[!-~]{8,20}+\z/, allow_blank: true }
    validates :password_confirmation, on: :create,
                                      presence: true
  end
end
