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
      let(:new_attributes) { { title: 'Updated Title', body: 'Updated Body', kind: 'text' } }

      it 'updates the requested content' do
        patch :update, params: { discipline_id: discipline.id, id: content.id, content: new_attributes }
        content.reload
        expect(content.title).to eq('Updated Title')
        expect(content.body).to eq('Updated Body')
        expect(content.kind.to_sym).to eq(:text)
      end

      it 'redirects to the discipline path with a success notice' do
        patch :update, params: { discipline_id: discipline.id, id: content.id, content: new_attributes }
        expect(response).to redirect_to(admin_discipline_path(discipline))
        expect(flash[:notice]).to eq(I18n.t('message.update.success'))
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
end
