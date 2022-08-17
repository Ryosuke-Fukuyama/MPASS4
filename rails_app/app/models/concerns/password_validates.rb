module PasswordValidates
  extend ActiveSupport::Concern

  included do
    validates :encrypted_password,
      on: :create,
      presence: true,
      allow_blank: true,
      format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)(?=.*?[!-\/:-@\[-`{-~])[!-~]{8,20}+\z/ }
  end
end