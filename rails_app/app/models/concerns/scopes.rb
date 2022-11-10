module Scopes
  extend ActiveSupport::Concern

  included do
    scope :search_today, -> { where(created_at: Time.current.all_day) }
  end
end