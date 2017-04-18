require 'rails_helper'

RSpec.describe AuthenticationController, type: :routing do
  describe 'routing' do

    it 'routes to #create' do
      expect(post: '/authentication').to route_to('authentication#create')
    end
  end
end
