class Patient < ApplicationRecord
#   has_many :health_interviews, dependent: :destroy
#   has_many :sns_credentials, dependent: :destroy
#   has_many :favorite_hospitals, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :lockable,
         :confirmable
        #  :timeoutable, :trackable
        #  :omniauthable, omniauth_providers: [:google_oauth2]

  validates :name,    presence: true,
                      length: { in: 2..20, allow_blank: true }
  validates :email,   presence: true,
                      uniqueness: true,
                      length: { maximum: 255 }
  validates :encrypted_password, on: :create,
                      presence: true
                     #  format: { with: /\A(?=.*?[a-z])(?=.*?\d)\w{6,20}\z/ }
  validates :tel,     numericality: { only_integer: true },
                      allow_blank: true
                     #  format: { with: /\A\d{10,11}\z/ }
  validates :address, length: { maximum: 255 }

  before_validation :email_downcase

  # scope :search_patient, -> (hospital_id) do
  #   relevanted_interviews(hospital_id)
  #     .search_patient_ids(relevanted_interviews)
  # end
  # scope :relevanted_interviews, -> (hospital_id) {
  #   relevanted_interviews = HealthInterview.where(hospital_id: hospital_id)
  # }
  # scope :search_patient_ids, -> (relevanted_interviews) {
  #   patient_ids = relevanted_interviews.pluck(:patient_id)
  #   where(id: patient_ids)
  # }

  attr_accessor :login

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(['name = :value OR lower(email) = lower(:value)', { value: login }]).first
  #   else
  #     where(conditions).first
  #   end
  # end

  # def self.find_create_for_google(auth)
  #   patient = Patient.where(email: auth.info.email)
  #   sns_credential_record = SnsCredential.where(provider: auth.provider, uid: auth.uid)
  #   if patient.present? && !sns_credential_record.present?
  #     SnsCredential.create(
  #       # patient_id: patient.ids,
  #       provider: auth.provider,
  #       uid: auth.uid
  #     )
  #   elsif patient = Patient.new(
  #     name: auth.info.name,
  #     email: auth.info.email,
  #     password: Devise.friendly_token[0, 20]
  #   )
  #     SnsCredential.new(
  #       provider: auth.provider,
  #       uid: auth.uid,
  #       patient_id: patient.id
  #       # meta:     auth.to_yaml
  #     )

  #     patient.skip_confirmation!
  #     patient.save
  #   end
  #   patient
  # end

  def email_downcase
    return if email.blank?

    self.email = email.downcase!
  end
end
