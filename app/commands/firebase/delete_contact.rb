module Firebase
  class DeleteContact
    include Firebase::Modules::ContactCommand

    def initialize(organization, contact_id)
      @organization = organization
      @contact_id = contact_id
    end

    def call
      return false unless response.success?
      true
    end

    private

    attr_accessor :contact_id

    def response_action
      firebase_client.delete(path)
    end

    def contacts_path
      "/contacts/#{contact_id}"
    end
  end
end
