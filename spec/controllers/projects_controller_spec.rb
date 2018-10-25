# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:project) { FactoryBot.create(:project) }
  let(:project_attributes) { FactoryBot.attributes_for(:project) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do
    before do
      project
      get :index
    end

    context 'when cancancan does not allow #index' do
      before do
        ability.cannot :index, Project
        get :index
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST #create' do
    context 'when cancancan does not allow :create' do
      before do
        ability.cannot :create, Project
        post :create, params: { project: { title: project.title } }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when success save' do
      before do
        post :create, params: { project: { title: project.title } }
      end

      it 'generate @project' do
        expect(assigns(:project)).not_to be_nil
      end

      it 'save project' do
        post :create, params: { project: { title: project.title } }
      end
    end

    context 'when invalid save' do
      before do
        post :create, params: { project: { title: '' } }
      end

      it 'generate fail message' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when success update' do
      before { patch :update, params: { id: project.id, project: { title: 'new title' } } }

      context 'when cancancan does not allow :update' do
        before do
          ability.cannot :update, Project
          patch :update, params: { id: project.id, project: { title: 'new title' } }
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end

      it 'generate @project' do
        expect(assigns(:project)).not_to be_nil
      end

      it '#update project' do
        patch :update, params: { id: project.id, project: { title: project.title } }
      end
    end

    context 'when invalid update' do
      before do
        patch :update, params: { id: project.id, project: { title: '' } }
      end

      it 'generate fail message' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: project.id }
    end

    context 'when cancancan does not allow :destroy' do
      before do
        ability.cannot :destroy, Project
        delete :destroy, params: { id: project.id }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it 'generate @project' do
      expect(assigns(:project)).not_to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
