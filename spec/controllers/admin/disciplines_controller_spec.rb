require 'rails_helper'

RSpec.describe Admin::DisciplinesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user, :admin) }
    let!(:disciplines) { create_list(:discipline, 2) }

    context 'authorized user' do
      before do
        sign_in(user)
        get :index
      end

      it 'assigns @disciplines' do
        expect(assigns(:disciplines)).to eq(disciplines)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'limits the number of disciplines to 15' do
        expect(assigns(:disciplines).count).to eq(2)
      end
    end

    context 'without authorization' do
      before do
        get :index
      end

      it 'unassigns authorization' do
        expect(assigns(:disciplines)).not_to eq(disciplines)
      end

      it 'cannot render the index template' do
        expect(response).not_to render_template(:index)
      end

      it '0 disciplines assigned' do
        expect(assigns(:disciplines)).to be_nil
      end
    end
  end
end
