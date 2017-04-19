module Firebase
  class GetContact
    include Firebase::Modules::ContactCommand

    def initialize(organization, contact_id)
      @organization = organization
      @contact_id = contact_id
    end

    def call
      return unsuccessful_response unless response.success?
      return nil if response_body.blank?

      attributes = {id: contact_id}.merge response_body
      Contact.new(attributes)
    end

    private

    attr_accessor :contact_id

    def response_action
      firebase_client.get(path)
    end

    def contacts_path
      "/contacts/#{contact_id}"
    end
  end
end
