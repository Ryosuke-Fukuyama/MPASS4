class Staff < ApplicationRecord
  belongs_to  :hospital

  include PasswordValidates

  validates :name, presence: true,
                   uniqueness: true,
                   length: { in: 1..20, allow_blank: true }

  # before_destroy :admin_not_delete
  # before_update :self_admin_not

  devise :database_authenticatable,
         :validatable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: [:name]

  private
  # def admin_not_delete
  #   staff = Staff.find(id)
  #   throw(:abort) if staff.admin?
  # end

  # def self_admin_not
  #   staff = Staff.find(id)
  #   throw(:abort) if staff.id == current_staff.id
  # end

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
