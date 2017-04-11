module Firebase
  class SetContact
    prepend SimpleCommand

    def initialize(organization, params)
      @organization = organization
      @params = params
    end

    def call
      set_errors_from_object unless contact.valid?
      return nil if response_body.blank? || errors.present?
      errors.add "Response raw body: #{response_raw_body}" unless response.success?

      contact.id = response_body['name']
      return contact
    end

    private

    attr_accessor :organization, :params

    def firebase_client
      @firebase_client ||= Firebase::Client.new(ENV['FIREBASE_URI'], ENV['FIREBASE_SECRET'])
    end

    def response
      @response ||= firebase_client.push(path, params)
    end

    def response_body
      response.body
    end

    def response_raw_body
      response.raw_body
    end

    def contact
      @contact ||= Contact.new(params)
    end

    def set_errors_from_object
      contact.errors.messages.each do |key, value|
        errors.add(key, value.first)
      end
    end

    def path
      "#{organization_root_path}/#{organization.id}/contacts"
    end

    def organization_root_path
      organization.class.name.downcase.underscore
    end
  end
end
