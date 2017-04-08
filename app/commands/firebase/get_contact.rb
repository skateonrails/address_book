module Firebase
  class GetContact
    prepend SimpleCommand

    def initialize(organization, contact_id)
      @organization = organization
      @contact_id = contact_id
    end

    def call
      return errors.add "Response raw body: #{response_raw_body}" unless response.success?
      return nil if response_body.blank?

      Contact.new(response_body)
    end

    private

    attr_accessor :organization, :contact_id

    def firebase_client
      @firebase_client ||= Firebase::Client.new(ENV['FIREBASE_URI'], ENV['FIREBASE_SECRET'])
    end

    def response
      @response ||= firebase_client.get(path)
    end

    def response_body
      response.body
    end

    def response_raw_body
      response.raw_body
    end

    def path
      "#{organization_root_path}/#{organization.id}/contacts/#{contact_id}"
    end

    def organization_root_path
      organization.class.name.downcase.underscore
    end
  end
end
