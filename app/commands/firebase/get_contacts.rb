module Firebase
  class GetContacts
    include Firebase::Modules::ContactCommand

    def initialize(organization)
      @organization = organization
    end

    def call
      return unsuccessful_response unless response.success?
      return [] if response_body.blank?

      response_body.map{|key, hash_data| Contact.new({id: key}.merge(hash_data))}
    end

    private

    def response_action
      firebase_client.get(path)
    end

    def contacts_path
      "/contacts"
    end
  end
end
