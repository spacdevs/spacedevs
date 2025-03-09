require 'rails_helper'

RSpec.describe Admin::DisciplinesController, type: :controller do
  let(:user) { create(:user, :admin) }

  describe 'GET #index' do
    context '#index' do
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
      it_behaves_like 'unauthorized access', :get, :index
    end
  end

  describe 'GET #new' do
    context 'authorized user' do
      before do
        sign_in(user)
        get :new
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'without authorization' do
      it_behaves_like 'unauthorized access', :get, :new
    end
  end

  describe 'POST #create' do
    let(:team) { create(:team) }
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

    context 'authorized user' do
      before { sign_in(user) }

      it 'creates a discipline successfully' do
        post :create, params: params

        expect(flash[:notice]).to eq('Disciplína criado(a) com sucesso.')
        expect(Discipline.count).to eq 1
      end
    end

    context 'without authorization' do
      before do
        post :create, params: params
      end

      it 'does not create a discipline' do
        expect(flash[:notice]).to be_nil
        expect(Discipline.count).to be_zero
      end
    end

    context 'without authorization' do
      it_behaves_like 'unauthorized access', :get, :create, { id: 1 }
    end
  end

  describe 'GET #edit' do
    context '#edits' do
      let(:discipline) { create(:discipline) }

      before do
        sign_in(user)
        get :edit, params: { id: discipline.id }
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'without authorization' do
      it_behaves_like 'unauthorized access', :get, :edit, { id: 1 }
    end
  end

  describe 'UPDATE #update' do
    let(:discipline) { create(:discipline, position: 1) }
    let(:params) do
      {
        id: discipline.id,
        discipline: {
          title: 'Introdução aos algoritmos',
          abstract: 'Aprenda a criar algoritimos',
          body: 'Conteúdo sobre algoritmos',
          available_on: Time.zone.local(2025, 10, 12, 8, 0, 0),
          position: 2,
          team_name: create(:team, name: 'Colegio Salvador - Turma 03').name
        }
      }
    end

    context 'successfuly' do
      before { sign_in(user) }

      it 'updates discipline' do
        put :update, params: params
        discipline.reload

        expect(flash[:notice]).to eq('Registro atualizado com sucesso.')
        expect(discipline.title).to eq 'Introdução aos algoritmos'
        expect(discipline.abstract).to eq 'Aprenda a criar algoritimos'
        expect(discipline.body).to eq 'Conteúdo sobre algoritmos'
        expect(I18n.l(discipline.available_on, format: :short)).to eq '12 de outubro, 08:00'
        expect(discipline.position).to eq 2
      end
    end

    it_behaves_like 'unauthorized access', :put, :update, id: 1
  end
end
