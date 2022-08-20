module AddressValidates
  extend ActiveSupport::Concern

  included do
    validates :address, length: { maximum: 255 },
                        if: :address?
  end
end