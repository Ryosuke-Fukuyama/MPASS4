module EmailValidates
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true
    validates :email, uniqueness: true,
                      format: { with: /\A[^@\s]+@[^@\s]+\z/ },
                      length: { maximum: 255 },
                      allow_blank: true

    before_validation {
      def email_downcase
        return if email.blank?

        self.email = email.downcase
      end
    }
  end
end