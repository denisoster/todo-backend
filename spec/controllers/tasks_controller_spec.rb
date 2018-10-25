# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:project) { FactoryBot.create(:project) }
  let(:task) { FactoryBot.create(:task) }
  let(:task_attributes) { FactoryBot.attributes_for(:task) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do
    before do
      task
      get :index, params: { project_id: project.id }
    end

    context 'when cancancan does not allow #index' do
      before do
        ability.cannot :index, Task
        get :index
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST #create' do
    context 'when cancancan does not allow :create' do
      before do
        ability.cannot :create, Task
        post :create, params: { task: { title: task.title } }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when success save' do
      before do
        post :create, params: { task: { title: task.title } }
      end

      it 'generate @task' do
        expect(assigns(:task)).not_to be_nil
      end

      it 'save task' do
        post :create, params: { task: { title: task.title } }
      end
    end

    context 'when invalid save' do
      before do
        post :create, params: { task: { title: '' } }
      end

      it 'generate fail message' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when success update' do
      before { patch :update, params: { id: task.id, task: { title: 'new title' } } }

      context 'when cancancan does not allow :update' do
        before do
          ability.cannot :update, Task
          patch :update, params: { id: task.id, task: { title: 'new title' } }
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end

      it 'generate @task' do
        expect(assigns(:task)).not_to be_nil
      end

      it '#update task' do
        patch :update, params: { id: task.id, task: { title: task.title } }
      end
    end

    context 'when invalid update' do
      before do
        patch :update, params: { id: task.id, task: { title: '' } }
      end

      it 'generate fail message' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: task.id }
    end

    context 'when cancancan does not allow :destroy' do
      before do
        ability.cannot :destroy, Task
        delete :destroy, params: { id: task.id }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it 'generate @task' do
      expect(assigns(:task)).not_to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
