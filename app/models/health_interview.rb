class HealthInterview < ApplicationRecord
  belongs_to :patient
  belongs_to :hospital
  has_one :guide_status, dependent: :destroy
  accepts_nested_attributes_for :guide_status, allow_destroy: true

  # validates :price, numericality: { only_integer: true }

  enum gender: { man: 0, woman: 1 }

  include Scopes
  scope :search_waiting, -> { where(guide_statuses: { status: 'waiting' }) }
  scope :search_calling, -> { where(guide_statuses: { status: 'calling' }) }
  scope :search_pending, -> { where(guide_statuses: { status: 'pending' }) }
  scope :search_payment, -> { where(guide_statuses: { status: 'payment' }) }
  scope :search_noshow, -> { where(guide_statuses: { status: 'noshow' }) }
end
