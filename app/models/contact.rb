class Contact
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Serializers::JSON
  include ActiveModel::Conversion

  # :reek:Attribute
  attr_accessor :id,
                :name,
                :city,
                :state,
                :country,
                :street_address,
                :secondary_address,
                :building_number,
                :zip_code

  validates :id, :name, :zip_code, :street_address, :building_number, presence: true
  validates :city, :state, :country, presence: true
  validates :building_number, numericality: { only_integer: true }

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    {
      name: nil,
      city: nil,
      state: nil,
      country: nil,
      street_address: nil,
      secondary_address: nil,
      building_number: nil,
      zip_code: nil
    }
  end

  def persisted?
    id.present?
  end
end
