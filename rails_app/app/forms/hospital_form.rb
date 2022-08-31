class HospitalForm < YAAF::Form
  attr_accessor :hospital,
                :id,
                :name,
                :email,
                :tel,
                :address,
                :access,
                :introduction,
                :image
  attr_writer :hospitals_attributes,
              :hospital_label_ids,
              :staffs_attributes

  delegate :persisted?, to: :hospital

  def initialize(attributes = nil, hospital: Hospital.new)
    @hospital = hospital
    @attributes = (attributes || {})

    if attributes.present?
      super(hospital_attributes)
    else
      self.id = @hospital.id
      self.name = @hospital.name
      self.email = @hospital.email
      self.tel = @hospital.tel
      self.address = @hospital.address
      self.access = @hospital.access
      self.introduction = @introduction
      self.image = @hospital.image
    end

    @hospital.assign_attributes(
      name: name,
      email: email,
      tel: tel,
      address: address,
      access: access,
      introduction: introduction,
      image: image
    )

    super(@attributes)
    @models = [@hospital, hospital_label_ids, staffs].flatten
  end

  def hospital_label_ids
    super(hospital_label_ids)
  end

  def staffs
    return @staffs if defined?(@staffs)
    @staffs = []

    if hospital.staffs.present?
      hospital.staffs.each do |staff|
        attr = staffs_attributes.values&.find { |val| val["id"].to_i == staff.id }
        @staffs << StaffForm.new(attr, staff: staff)
      end
    else
      # 2.times { @staffs << StaffForm.new(staffs_attributes&.dig(_1.to_s), staff: hospital.staffs.build) }
    end

    @staffs
  end

  def to_model
    hospital
  end

  private

  def hospital_attributes
    @hospital_attributes ||= { name: @attributes[:name],
                               email: @attributes[:email],
                               tel: @attributes[:tel],
                               address: @attributes[:address],
                               access: @attributes[:access],
                               introduction: @attributes[:introduction],
                               image: @attributes[:image]
                              }
  end

  def hospital_label_ids
    @hospital_label_ids ||= (@attributes[:hospital_label_ids] || {} )
  end

  def staffs_attributes
    @staffs_attributes ||= (@attributes[:staffs_attributes] || {} )
  end
end