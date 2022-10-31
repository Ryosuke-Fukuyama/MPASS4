class GuideStatus < ApplicationRecord
  belongs_to :health_interview, optional: true

  STATUSES = {
    initial: 0,
    calling: 1,
    pending: 2,
    noshow: 3,
    payment: 4,
    complete: 5
  }
  enum status: STATUSES

  validates :status, inclusion: { in: STATUSES.keys.concat(STATUSES.keys.map(&:to_s)) }, exclusion: { in: [nil] }
end
