require 'rails_helper'

RSpec.describe GuideStatus, type: :model do
  describe 'enum status' do
    it {
      expect(subject).to define_enum_for(:status).with_values(
        initial: 0,
        calling: 1,
        done: 2,
        pending: 3,
        noshow: 4,
        complete: 5
      )
    }
  end
end
