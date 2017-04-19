module Firebase
  class UpdateContact
    include Firebase::Modules::ContactCommand

    def initialize(organization, contact_id, params)
      @organization = organization
      @contact_id = contact_id
      @params = params
    end

    def call
      set_errors_from_object unless contact.valid?
      return nil if errors.present? || response_body.blank?
      return unsuccessful_response unless response.success?

      contact.id = contact_id
      contact
    end

    private

    attr_accessor :contact_id, :params

    def response_action
      firebase_client.update(path, params)
    end

    def contact
      @contact ||= Contact.new(params)
    end

    def set_errors_from_object
      contact.errors.messages.each do |key, value|
        errors.add(key, value.first)
      end
    end

    def contacts_path
      "/contacts/#{contact_id}"
    end
  end
end
