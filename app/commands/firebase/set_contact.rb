module Firebase
  class SetContact
    include Firebase::Modules::ContactCommand

    def initialize(organization, params)
      @organization = organization
      @params = params
    end

    def call
      set_errors_from_object unless contact.valid?
      return nil if errors.present? || response_body.blank?
      return unsuccessful_response unless response.success?

      contact.id = response_body['name']
      contact
    end

    private

    attr_accessor :params

    def response_action
      firebase_client.push(path, params)
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
      "/contacts"
    end
  end
end
