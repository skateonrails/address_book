module Firebase::Modules::ContactCommand
  def self.included(base)
    base.send(:prepend, SimpleCommand)
  end

  private

  def unsuccessful_response
    errors.add :response, response_raw_body
  end

  def response_action
    raise 'Must be implemented'
  end

  def contacts_path
    raise 'Must be implemented'
  end

  def path
    "#{organization_root_path}/#{organization.id}#{contacts_path}"
  end

  def organization
    @organization
  end

  def response
    @response ||= response_action
  end

  def firebase_client
    @firebase_client ||= Firebase::Client.new(ENV['FIREBASE_URI'], ENV['FIREBASE_SECRET'])
  end

  def response_body
    response.body
  end

  def response_raw_body
    response.raw_body
  end

  def organization_root_path
    organization.class.name.downcase.underscore
  end
end
