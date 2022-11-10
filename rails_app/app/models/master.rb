class Master < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: true,
                   length: { in: 2..20, allow_blank: true }
  include EmailValidates
  include PasswordValidates

  before_destroy :master_validation

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
   def master_validation
    if Master.all.size <= 1
      # flash.now[:alert] = t('alert.master_size')
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
