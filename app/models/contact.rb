class Contact
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Serializers::JSON

  # :reek:Attribute
  attr_accessor :name,
                :city,
                :state,
                :country,
                :street_address,
                :secondary_address,
                :building_number,
                :zip_code

  validates :name, :zip_code, :street_address, :building_number, presence: true
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
end
