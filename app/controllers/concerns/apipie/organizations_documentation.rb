module Apipie::OrganizationsDocumentation
  extend ActiveSupport::Concern

  included do
    resource_description do
      short 'API to manage organizations'
      formats ['json']
      error 401, 'Unauthorized'
      description <<-EOD
      === Authentication Required
       - Authentication token has to be passed as HTTP header(HTTP_AUTHORIZATION);
       - Authentication token has to represent an admin user
      EOD
    end

    api :GET, 'organizations', 'List all organizations'
    def index; end

    api :GET, 'organizations/:id', 'Show organization'
    param :id, String, desc: 'Organization ID', required: true
    error 404, 'Organization not found'
    def show; end

    api :POST, 'organizations/', 'Create organization'
    param :organization, Hash do
      param :name, String, desc: 'Organization name', required: true
    end
    error 422, 'Organization unable to create'
    def create; end

    api :PUT, 'organizations/:id', 'Update organization'
    param :id, String, desc: 'Organization id', required: true
    param :organization, Hash do
      param :name, String, desc: 'Organization name', required: true
    end
    error 404, 'Organization not found'
    error 422, 'Organization unable to be saved'
    def update; end

    api :DELETE, 'organizations/:id', 'Destroy organization'
    param :id, String, desc: 'Organization id', required: true
    error 404, 'Organization not found'
    def destroy; end
  end
end
