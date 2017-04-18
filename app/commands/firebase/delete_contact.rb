module Firebase
  class DeleteContact
    prepend SimpleCommand

    def initialize(organization, contact_id)
      @organization = organization
      @contact_id = contact_id
    end

    def call
      return false unless response.success?
      return true
    end

    private

    attr_accessor :organization, :contact_id

    def firebase_client
      @firebase_client ||= Firebase::Client.new(ENV['FIREBASE_URI'], ENV['FIREBASE_SECRET'])
    end

    def response
      @response ||= firebase_client.delete(path)
    end

    def path
      "#{organization_root_path}/#{organization.id}/contacts/#{contact_id}"
    end

    def organization_root_path
      organization.class.name.downcase.underscore
    end
  end
end
