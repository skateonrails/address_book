require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #login' do
      expect(post: '/users/login').to route_to('users#login')
    end

    it 'routes to #login' do
      expect(post: '/users').to route_to('users#create')
    end
  end
end
