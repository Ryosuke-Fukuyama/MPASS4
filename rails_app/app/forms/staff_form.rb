class StaffForm < YAAF::Form
  attr_accessor :id,
                :name,
                :password,
                :password_confirmation,
                # encrypted_password,
                :admin

  def initialize(attributes = nil, staff: Staff.new)
    @staff = staff

    if attributes.present?
      super(attributes)
    else
      self.id = @staff.id
      self.name = @staff.name
      self.password = @staff.password
      self.password_confirmation = @staff.password_confirmation
      self.admin = @staff.admin
    end

    @staff.assign_attributes(
      name: name,
      password: password,
      password_confirmation: password_confirmation,
      admin: admin
    )

    @models = [@staff]
  end

  def to_model
    @staff
  end
end