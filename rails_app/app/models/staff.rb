class Staff < ApplicationRecord
  belongs_to  :hospital

  devise :database_authenticatable,
         :validatable,
         :lockable,
         :timeoutable,
         :trackable,
         authentication_keys: [:name]


  validates :name,               presence: true,
                                 length: { in: 1..20, allow_blank: true }
  validates :encrypted_password, on: :create,
                                 presence: true
                                # format: { with: /\A(?=.*?[a-z])(?=.*?\d)\w{6,20}\z/ }

  # before_destroy :admin_not_delete
  # before_update :self_admin_not

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

  def will_save_change_to_email?
    false
  end
end
