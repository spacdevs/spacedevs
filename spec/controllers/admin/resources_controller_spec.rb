# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ResourcesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:valid_attributes) { attributes_for(:resource, sourceable_id: discipline).except(:sourceable) }
  let(:invalid_attributes) { { name: nil, url: nil } }
  let!(:resource) { create(:resource, :with_discipline) }
  let(:discipline) { create(:discipline) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: resource.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Resource' do
        expect do
          post :create, params: { resource: valid_attributes }
        end.to change(Resource, :count).by(1)
      end

      it 'redirects to the resources list' do
        post :create, params: { resource: valid_attributes }
        expect(response).to redirect_to(admin_resources_path)
      end
    end

    xcontext 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { resource: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested resource' do
        valid_attributes[:name] = 'Novo Nome'

        patch :update, params: { id: resource.id, resource: valid_attributes }
        resource.reload
        expect(resource.name).to eq('Novo Nome')
      end

      it 'redirects to the resources list' do
        valid_attributes[:name] = 'Novo Nome'

        patch :update, params: { id: resource.id, resource: valid_attributes }
        expect(response).to redirect_to(admin_resources_path)
      end
    end

    xcontext 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { id: resource.id, resource: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested resource' do
      expect do
        delete :destroy, params: { id: resource.id }
      end.to change(Resource, :count).by(-1)
    end

    it 'redirects to the resources list' do
      delete :destroy, params: { id: resource.id }
      expect(response).to redirect_to(admin_resources_path)
    end
  end
end
