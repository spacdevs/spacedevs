require 'rails_helper'

RSpec.describe Admin::DisciplinesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user, :admin) }

    context 'authorized user' do
      let!(:disciplines) { create_list(:discipline, 2) }

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
      let(:disciplines) { create_list(:discipline, 2) }

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

  describe 'GET #new' do
    let(:user) { create(:user, :admin) }

    context 'successfully' do
      before do
        sign_in(user)
        get :new
      end

      it 'renders the index template' do
        expect(response).to render_template(:new)
      end
    end

    context 'without authorization' do
      before do
        get :new
      end

      it 'cannot render the index template' do
        expect(response).not_to render_template(:index)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user, :admin) }
    let(:team) { create(:team) }

    context 'create a discipline' do
      let(:params) do
        {
          discipline: {
            title: 'Introdução a tecnologia',
            abstract: 'Tudo sobre tecnologia',
            body: 'Introdução a disciplina de tecnologia da informação',
            available_on: DateTime.current.to_s,
            position: 1,
            team_name: team.name
          }
        }
      end

      it 'successfully' do
        sign_in(user)
        post :create, params: params

        expect(flash[:notice]).to eq('Disciplína criado(a) com sucesso.')
        expect(Discipline.count).to eq 1
      end

      it 'no authorization' do
        post :create, params: params

        expect(flash[:notice]).to be_nil
        expect(Discipline.count).to be_zero
      end
    end
  end
end
