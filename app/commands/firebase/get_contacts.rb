module Firebase
  class GetContacts
    prepend SimpleCommand

    def initialize(organization)
      @organization = organization
    end

    def call
      return errors.add "Response raw body: #{response_raw_body}" unless response.success?
      return [] if response_body.blank?

      response_body.map{|key, hash_data| Contact.new({id: key}.merge(hash_data))}
    end

    private

    attr_accessor :organization

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
      "#{organization_root_path}/#{organization.id}/contacts"
    end

    def organization_root_path
      organization.class.name.downcase.underscore
    end
  end
end
