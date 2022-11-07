class Staff < ApplicationRecord
  belongs_to  :hospital

  validates :name, presence: true,
                   #  uniqueness: { scope: hospital_id }, # 同病院内での制限をつけたい
                   length: { in: 2..20, allow_blank: true }
  include PasswordValidates

  before_update :admin_validation
  before_destroy :admin_validation

  devise :database_authenticatable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: [:name]

  private

  def admin_validation
    if Staff.select { admin? }.size <= 1
      # flash[:alert] = t('alert.admin_size') # <-undefined local variable or method `flash' for
      throw(:abort)
    end
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
