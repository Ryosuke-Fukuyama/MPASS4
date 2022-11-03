module PasswordValidates
  extend ActiveSupport::Concern

  included do
    validates :password, on: :create,
                         presence: true,
                         format: { with: %r{\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)(?=.*?[!-/:-@\[-`{-~])[!-~]{8,20}+\z}, allow_blank: true }
  end
end
