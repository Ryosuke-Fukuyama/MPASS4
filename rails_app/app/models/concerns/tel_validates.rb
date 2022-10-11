module TelValidates
  extend ActiveSupport::Concern

  included do
    validates :tel, length: { in: 10..11, allow_blank: true }
                    # numericality: { only_integer: true }

    # # "NoMethodError: undefined method `size' for nil:NilClass"
    # after_validation {
    #   if tel?(
    #     case tel.size
    #       when 10; tel.gsub(/(\d{2})(\d{4})(\d{4})/, '\1_\2_\3')
    #       when 11; tel.gsub(/(\d{3})(\d{4})(\d{4})/, '\1_\2_\3')
    #     end
    #   )
    #   end
    # }
  end
end