module Apipie::UsersDocumentation
  extend ActiveSupport::Concern

  included do
    resource_description do
      short 'User log in and register'
      formats ['json']
    end

    api :POST, 'users/login', 'Log in user'
    param :email, String, desc: 'user email', required: true
    param :password, String, desc: 'user password', required: true
    error 401, 'User email/password not found'
    def login; end

    api :POST, 'users', 'Register user'
    param :user, Hash, required: true do
      param :email, String, desc: 'user email', required: true
      param :password, String, desc: 'user password', required: true, meta: { length: "Must have at least 5 characters" }
      param :organization_ids, Array, of: Integer, desc: 'Organizations IDs that user is associated to', required: false
    end
    error 422, 'Email is invalid'
    def create; end
  end
end
