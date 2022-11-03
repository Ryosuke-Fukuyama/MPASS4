class Master < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: true,
                   length: { in: 1..20, allow_blank: true }
  include EmailValidates
  include PasswordValidates

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         #  :rememberable,
         :confirmable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: %i[name email]

  private

  def email_required?
    false
  end

  def _changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
