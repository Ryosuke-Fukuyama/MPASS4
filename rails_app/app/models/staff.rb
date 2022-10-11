class Staff < ApplicationRecord
  belongs_to  :hospital

  validates :name, presence: true,
                  #  uniqueness: { scope: hospital_id }, # 同病院内での制限をつけたい
                   length: { in: 1..20, allow_blank: true }
  include PasswordValidates

  devise :database_authenticatable,
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
