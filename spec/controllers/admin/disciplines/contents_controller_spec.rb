require 'rails_helper'

RSpec.describe Admin::Disciplines::ContentsController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:discipline) { create(:discipline) }
  let(:content) { create(:content, discipline: discipline) }

  before do
    sign_in admin_user
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { discipline_id: discipline.id, id: content.id }
      expect(response).to be_successful
    end

    it 'assigns the requested content to @content' do
      get :edit, params: { discipline_id: discipline.id, id: content.id }
      expect(assigns(:content)).to eq(content)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'Updated Title', body: 'Updated Body', kind: 'text', position: 5 } }

      it 'updates the requested content' do
        patch :update, params: { discipline_id: discipline.id, id: content.id, content: new_attributes }
        content.reload
        expect(content.title).to eq('Updated Title')
        expect(content.body.to_plain_text).to eq('Updated Body')
        expect(content.kind.to_sym).to eq(:text)
        expect(content.position).to eq(5)
      end

      it 'redirects to the discipline path with a success notice' do
        patch :update, params: { discipline_id: discipline.id, id: content.id, content: new_attributes }
        expect(response).to redirect_to(admin_discipline_path(discipline))
        expect(flash[:notice]).to eq(I18n.t('messages.update.success'))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { title: '', body: '', kind: '' } }

      it 'does not update the content' do
        patch :update, params: { discipline_id: discipline.id, id: content.id, content: invalid_attributes }
        content.reload
        expect(content.title).not_to eq('')
        expect(content.body).not_to eq('')
        expect(content.kind).not_to eq(:"")
      end

      it 'renders the edit template' do
        patch :update, params: { discipline_id: discipline.id, id: content.id, content: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { discipline_id: discipline.id }
      expect(response).to be_successful
    end

    it 'assigns a new content to @content' do
      get :new, params: { discipline_id: discipline.id }
      expect(assigns(:content)).to be_a_new(Content)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { { title: 'New Title', body: 'New Body', kind: 'text' } }

      it 'creates a new content' do
        expect do
          post :create, params: { discipline_id: discipline.id, content: valid_attributes }
        end.to change(Content, :count).by(1)
      end

      it 'redirects to the discipline path with a success notice' do
        post :create, params: { discipline_id: discipline.id, content: valid_attributes }
        expect(response).to redirect_to(admin_discipline_path(discipline))
        expect(flash[:notice]).to eq(I18n.t('messages.update.success'))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { title: '', body: '', kind: '' } }

      it 'does not create a new content' do
        expect do
          post :create, params: { discipline_id: discipline.id, content: invalid_attributes }
        end.not_to change(Content, :count)
      end

      it 'renders the new template' do
        post :create, params: { discipline_id: discipline.id, content: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
