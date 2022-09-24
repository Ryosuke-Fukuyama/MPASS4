class Master < ApplicationRecord

  include EmailValidates
  include PasswordValidates
  validates :name, presence: true,
                   uniqueness: true,
                   length: { in: 1..20, allow_blank: true }

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: [:name]


end
