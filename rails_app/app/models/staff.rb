class Staff < ApplicationRecord
  belongs_to  :hospital

  include PasswordValidates

  validates :name, presence: true,
                  #  uniqueness: true, # 同病院内での制限をつけたい
                   length: { in: 1..20, allow_blank: true }

  devise :database_authenticatable,
         :validatable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: [:name]

  private

    def admin_limiter
      throw(:abort) if Staff.select{admin?}.size <= 1
    end

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
