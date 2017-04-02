require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:organization) { create(:organization) }

  describe "GET #index" do
    it "returns http success" do
      get :index, params: {organization_id: organization.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {organization_id: organization.id, id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create, params: {organization_id: organization.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      put :update, params: {organization_id: organization.id, id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      delete :destroy, params: {organization_id: organization.id, id: 1}
      expect(response).to have_http_status(:success)
    end
  end

end
