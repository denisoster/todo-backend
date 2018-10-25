# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:task) { FactoryBot.create(:task) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:comment_attributes) { FactoryBot.attributes_for(:comment) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  describe 'GET #index' do
    before do
      comment
      get :index, params: { task_id: task.id }
    end

    context 'when cancancan does not allow #index' do
      before do
        ability.cannot :index, Comment
        get :index
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST #create' do
    context 'when cancancan does not allow :create' do
      before do
        ability.cannot :create, Comment
        post :create, params: { comment: { description: comment.description } }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'when success save' do
      before do
        post :create, params: { comment: { description: comment.description, task_id: task.id } }
      end

      it 'generate @comment' do
        expect(assigns(:comment)).not_to be_nil
      end

      it 'save comment' do
        post :create, params: { comment: { description: comment.description } }
      end
    end

    context 'when invalid save' do
      before do
        post :create, params: { comment: { description: '' } }
      end

      it 'generate fail message' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when success update' do
      before do
        patch :update, params: { id: comment.id, comment: { description: 'new description' } }
      end

      context 'when cancancan does not allow :update' do
        before do
          ability.cannot :update, Comment
          patch :update, params: { id: comment.id, comment: { description: 'new description' } }
        end

        it { expect(response).to have_http_status(:unauthorized) }
      end

      it 'generate @comment' do
        expect(assigns(:comment)).not_to be_nil
      end

      it '#update comment' do
        patch :update, params: { id: comment.id, comment: { description: comment.description } }
      end
    end

    context 'when invalid update' do
      before do
        patch :update, params: { id: comment.id, comment: { description: '' } }
      end

      it 'generate fail message' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: comment.id }
    end

    context 'when cancancan does not allow :destroy' do
      before do
        ability.cannot :destroy, Comment
        delete :destroy, params: { id: comment.id }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it 'generate @comment' do
      expect(assigns(:comment)).not_to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
