class Staff < ApplicationRecord
  belongs_to  :hospital

  validates :name, presence: true,
                   #  uniqueness: { scope: hospital_id }, # 同病院内での制限をつけたい
                   length: { in: 2..20, allow_blank: true }
  validates :password, presence: true,
                       confirmation: true,
                       format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)(?=.*?[!-\/:-@\[-`{-~])[!-~]{8,20}+\z/, allow_blank: true }
  validates :password_confirmation, presence: true

  before_update :admin_validation
  before_destroy :admin_validation

  devise :database_authenticatable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: [:name]

  private

  def admin_validation
    if Staff.select{|value| value[:admin] == true}.size <= 1
      # flash.now[:alert] = t('alert.admin_size') # Model内で使えない
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
