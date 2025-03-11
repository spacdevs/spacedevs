require 'rails_helper'

RSpec.describe Admin::TeamsController, type: :controller do
  let(:user) { create(:user, :admin) }

  describe 'GET #index' do
    context '#index' do
      let!(:teams) { create_list(:team, 2) }

      before do
        sign_in(user)
        get :index
      end

      it 'assigns @teams' do
        expect(assigns(:teams)).to eq(teams)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'limits the number of teams to 15' do
        expect(assigns(:teams).count).to eq(2)
      end
    end

    context 'without authorization' do
      it_behaves_like 'unauthorized access', :get, :index
    end
  end
  describe 'GET #new' do
    context '#new' do
      before do
        sign_in(user)
        get :new
      end

      it 'assigns a new team' do
        expect(assigns(:team)).to be_a_new(Team)
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
    context '#create' do
      let(:team_params) { attributes_for(:team) }

      before do
        sign_in(user)
        post :create, params: { team: team_params }
      end

      it 'creates a new team' do
        expect(Team.count).to eq(1)
      end

      it 'redirects to the team show page' do
        expect(response).to redirect_to(admin_teams_path)
      end
    end

    context 'without authorization' do
      it_behaves_like 'unauthorized access', :get, :new
    end
  end
end
