require 'rails_helper'

RSpec.describe ContactsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/organizations/1/contacts').to route_to('contacts#index', organization_id: '1')
    end


    it 'routes to #show' do
      expect(get: '/organizations/1/contacts/1').to route_to('contacts#show', id: '1', organization_id: '1')
    end


    it 'routes to #create' do
      expect(post: '/organizations/1/contacts').to route_to('contacts#create', organization_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/organizations/1/contacts/1').to route_to('contacts#update', id: '1', organization_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/organizations/1/contacts/1').to route_to('contacts#update', id: '1', organization_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/organizations/1/contacts/1').to route_to('contacts#destroy', id: '1', organization_id: '1')
    end

  end
end
