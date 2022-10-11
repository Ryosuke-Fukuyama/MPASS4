class HealthInterview < ApplicationRecord
  belongs_to :patient
  belongs_to :hospital
  has_one :guide_status, dependent: :destroy
  accepts_nested_attributes_for :guide_status, allow_destroy: true

  enum gender: { man: 0, woman: 1 }

  scope :search_initial, -> { where(guide_status: { status: 'initial' }) }
  scope :search_calling, -> { where(guide_status: { status: 'calling' }) }
  scope :search_pending, -> { where(guide_status: { status: 'pending' }) }
  scope :search_done, -> { where(guide_status: { status: 'done' }) }
  scope :search_noshow, -> { where(guide_status: { status: 'noshow' }) }
  scope :search_today, -> { where(updated_at: Time.current.all_day) }
end
