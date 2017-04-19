class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :state,
             :country, :street_address,
             :secondary_address, :building_number,
             :zip_code
end
